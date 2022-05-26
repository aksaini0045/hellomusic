

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:on_audio_query/on_audio_query.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:file_manager/file_manager.dart ' as mainfm;
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:on_audio_query/on_audio_query.dart';

class Songprovider with ChangeNotifier {
 
  // List<Directory> _storagedirectories;
  List<SongModel> songslist = [];
  List<Audio> audiolist = [];
  // int currentsongindex = 0;

  var _playerstatus = false;
 

  Future<void> initialloading() async {
   final  OnAudioQuery audioQuery= OnAudioQuery();
    // _storagedirectories = await getstoragedirectories();
    // await getmp3files(_storagedirectories);
   PermissionStatus _permissionStatus =await getpermission();
 
    if (_permissionStatus.isGranted) {

      songslist = await audioQuery.querySongs();
      songslist.removeWhere((element) => !(element.data.contains('.mp3')));
      print('initial');
      // songslist.forEach((element) {
      //   audiolist.add(Audio.file(element.filePath,
      //       metas: Metas(
      //         title: element.displayName,
      //       )));
      // });
      // print(audiolist[0].path);
      getaudiolist();
      if (songslist.isEmpty) print('empty');
    }
  }

  Future<PermissionStatus> getpermission() async {
    PermissionStatus temppermission = await Permission.storage.request();
    // Permission.bluetooth.request();
    return temppermission;
  }

  void getaudiolist() {
    print('getting');
    for (int i = 0; i < songslist.length; i++) {
      audiolist.add(Audio.file(
        songslist[i].data,
        metas: Metas(
          title: songslist[i].displayName,
          id: i.toString(),
        ),
      ));
    }
  }

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  void playaudio(int index) {
    assetsAudioPlayer.open(Playlist(audios: audiolist, startIndex: index),
        showNotification: true,
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeAfterInterruption: true),
        notificationSettings: const NotificationSettings(nextEnabled: true),
        autoStart: true,
        playInBackground: PlayInBackground.enabled,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug);
    _playerstatus = true;
    notifyListeners();
  }

  void playfromstart() {
    assetsAudioPlayer.open(Playlist(audios: audiolist, startIndex: 0),
        showNotification: true,
        audioFocusStrategy:
            AudioFocusStrategy.request(resumeAfterInterruption: true),
        notificationSettings: const NotificationSettings(
            nextEnabled: true, prevEnabled: true, seekBarEnabled: true),
        autoStart: true,
        playInBackground: PlayInBackground.enabled,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug);
    _playerstatus = true;
    notifyListeners();
  }

  bool getplayerstatus() {
    return _playerstatus;
  }

  // Future<List<Directory>> getstoragedirectories() async {
  //   List<Directory> tempstoragedirectories =
  //       await mainfm.FileManager.getStorageList();
  //   return tempstoragedirectories;
  // }

  // Future<void> getmp3files(List<Directory> storagedirectorylist) {
  //   List<FileSystemEntity> _tempsongs;

  //   _storagedirectories.forEach((storagetype) async {
  //     var rootdir = storagetype.path.toString();
  //     var flutterfm = FileManager(root: Directory(rootdir));
  //     _tempsongs = await flutterfm.filesTree(
  //         extensions: ['mp3'], excludedPaths: ['/storage/emulated/0/Android']);
  //     // songslist.addAll(_tempsongs);
  //   });
  // }

  // final AudioPlayer _audioPlayer = AudioPlayer();

  // void getplayerstate() {
  //   if (assetsAudioPlayer.isPlaying.value) {
  //     isplaying = true;

  //     print('playing');
  //   } else
  //     isplaying = false;

  //   print('paused');
  //   notifyListeners();
  // }

  // bool getcurrentstate() {
  //   return isplaying;
  // }

  // SongInfo getcurrentsong() {
  //   return songslist[currentsongindex];
  // }
}
