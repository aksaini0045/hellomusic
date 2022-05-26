import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:musicapp/screens/playingscree.dart';
import '../provider/provider.dart';

class ListTilewidget extends StatefulWidget {
  // ListTilewidget({Key key}) : super(key: key);
  int songindex;

  ListTilewidget(
    this.songindex,
  );

  @override
  _ListTilewidgetState createState() => _ListTilewidgetState();
}

class _ListTilewidgetState extends State<ListTilewidget> {
  // var isplaying = false;
  Songprovider provider=Songprovider();
  var isfirsttime = true;
  @override
  void didChangeDependencies() {
    if (isfirsttime) {
      provider = Provider.of<Songprovider>(context);
    }

    super.didChangeDependencies();
    isfirsttime = false;
  }

  void playsong(int songindex) {
   provider.playaudio(songindex);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PlayingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<Songprovider>(
        builder: (context, value, child) => ListTile(
            leading: Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(provider.audiolist[widget.songindex].metas.title!
                .split('.')
                .first),
            onTap: () {
              playsong(widget.songindex);
            }),
      ),
    );
  }
}
