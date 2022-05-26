// import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:on_audio_query/on_audio_query.dart';

import 'package:musicapp/screens/playingscree.dart';
import '../widgets/singlesong.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class Homescreen extends StatefulWidget {
  // Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Audio> _songsonhome = [];
  Songprovider songprovider = Songprovider();
  var playerstatus;
  // var playallclickedornot = false;

  @override
  void didChangeDependencies() {
    songprovider = Provider.of<Songprovider>(context, listen: true);
    playerstatus = songprovider.getplayerstatus();

    _songsonhome = Provider.of<Songprovider>(context, listen: false).audiolist;
    setState(() {});
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => showSearch(
                  context: context,
                  delegate: Searchsongs(_songsonhome, songprovider)),
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Play All',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                songprovider.playfromstart();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PlayingScreen()));
              },
            ),
          ),
          Container(
            height: devicesize.height * 0.742,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTilewidget(index);
              },
              itemCount: _songsonhome.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.music_note),
              Text(
                'Now \nPlaying',
                textAlign: TextAlign.center,
              )
            ],
          ),
          tooltip: 'Play Song Then Tap',
          onPressed: playerstatus
              ? () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PlayingScreen()));
                }
              : null),
    );
  }
}

class Searchsongs extends SearchDelegate<String> {
  Songprovider songprovider;
  List<Audio> songslist;
  Searchsongs(this.songslist, this.songprovider);

  // List<Audio> songsuggestion = [Audio.file()];
  // List<Map<String, dynamic>> suggestion;
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Card();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionlist = songslist
        .where((element) => element.metas.title!.toLowerCase().contains(query))
        .toSet()
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
          songprovider.playaudio(int.parse(suggestionlist[index].metas.id!));
          close(context, '');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PlayingScreen()));
        },
        leading: Icon(Icons.music_note),
        title: RichText(
          text: TextSpan(
            text: suggestionlist[index].metas.title!.substring(0, query.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            children: [
              TextSpan(
                  text: suggestionlist[index]
                      .metas
                      .title!
                      .substring(query.length)
                      .split('.')
                      .first,
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      itemCount: suggestionlist.length,
    );
  }
}
