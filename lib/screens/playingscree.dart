// import 'dart:ui' as ui;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';

class PlayingScreen extends StatefulWidget {
  // const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getmetadata();
  //   super.initState();
  // }

  // SongInfo song;
  // MetasImage art;

  // FlutterAudioQuery audioQuery = FlutterAudioQuery();
  // void getmetadata() async {
  //   // song = Provider.of<Songprovider>(context, listen: false).getcurrentsong();
  //   // var path =
  //   //     await audioQuery.getArtwork(type: ResourceType.ARTIST, id: song.id);

  //   // print(song.displayName);
  //   // art = _assetsAudioPlayer.getCurrentAudioImage;
  // }

  // var _play = false;
  @override
  Widget build(BuildContext context) {
    final playerprovider = Provider.of<Songprovider>(context);
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Column(
          children: [
            playerprovider.assetsAudioPlayer.builderLoopMode(
                builder: (context, loopMode) {
              return PlayerBuilder.isPlaying(
                player: playerprovider.assetsAudioPlayer,
                builder: (con, isplaying) => Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          playerprovider.assetsAudioPlayer.getCurrentAudioTitle
                              .substring(
                                  0,
                                  playerprovider.assetsAudioPlayer
                                              .getCurrentAudioTitle.length <
                                          21
                                      ? playerprovider.assetsAudioPlayer
                                          .getCurrentAudioTitle.length
                                      : 21)
                              .split('.')
                              .first,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: devicesize.height / 35,
                      ),
                      ClipRRect(
                        child: Container(
                            height: devicesize.height / 2.5,
                            child: Card(
                                elevation: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  'assets/images/music.jpg',
                                  fit: BoxFit.cover,
                                ))),
                      ),
                      SizedBox(
                        height: devicesize.height / 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 20,
                            child: IconButton(
                              onPressed: () async {
                                await playerprovider.assetsAudioPlayer
                                    .previous(keepLoopMode: true);
                              },
                              icon: const Icon(Icons.skip_previous),
                              iconSize: 40,
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 20,
                            child: IconButton(
                              onPressed: () {
                                playerprovider.assetsAudioPlayer.playOrPause();
                              },
                              icon: Icon(
                                  isplaying ? Icons.pause : Icons.play_arrow),
                              iconSize: 40,
                            ),
                          ),
                          Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                              onPressed: () async {
                                await playerprovider.assetsAudioPlayer
                                    .next(keepLoopMode: true);
                              },
                              icon: const Icon(Icons.skip_next),
                              iconSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(
              height: devicesize.height / 35,
            ),
            playerprovider.assetsAudioPlayer.builderRealtimePlayingInfos(
                builder: (context, RealtimePlayingInfos realtimePlayingInfos) {
              if (realtimePlayingInfos == null) {
                print('null');
                return const SizedBox(
                  height: 10,
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      playerprovider.assetsAudioPlayer
                          .seekBy(const Duration(seconds: -30));
                    },
                    icon: const Icon(Icons.fast_rewind),
                    label: const Text('30 Sec'),
                  ),
                  Text(
                      '${realtimePlayingInfos.currentPosition.toString().split('.').first.substring(2, 7)}/${realtimePlayingInfos.duration.toString().split('.').first.substring(2, 7)}'),
                  TextButton.icon(
                    onPressed: () {
                      playerprovider.assetsAudioPlayer
                          .seekBy(const Duration(seconds: 30));
                    },
                    icon: const Icon(Icons.fast_forward),
                    label: const Text('30 Sec'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
