// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';

import 'new_playlist_class.dart';

Color colorBlack = Colors.black;
Color colorWhite = Colors.white;
Color colorGreen = const Color(0xFF4FEC68);

List<String> allTheFavoriteVideosList = [];

ValueNotifier<List<Playlist>> playListnotifier = ValueNotifier([]);
// void addPlaylist(String playlistName,Playlist playlist)async {

//   final playlistDB=await Hive.openBox<Playlist>('playlist_db');
//     if (playlistDB.values.any((Playlist) => Playlist.name==playlistName)) {
//      print('allready exist');
//     }else{
//           final id = await playlistDB.add(playlist);
//           playlist.uniqueId=id;

//     }

//   if (playListnotifier.value.any((playlist) => playlist.name == playlistName)) {
//      print('already exist');
//     return;
//   }  else{
//       final newPlaylist = Playlist(name: playlistName);
//   playListnotifier.value.add(newPlaylist);
//   playListnotifier.notifyListeners();
//   }

// }
   

late List<AssetEntity> theallRecentListFortheSelectionPage;

late List<AssetEntity> theAllShortVideos;

Future<List<AssetEntity>> getLandscapeVideos(List<AssetEntity> videos) async {
  final result = <AssetEntity>[];

  for (final video in videos) {
    final duration = video.videoDuration;
    final aspectRatio = video.width / video.height;
    if (aspectRatio > 1 && (duration < const Duration(seconds: 32))&& duration> const Duration(seconds: 4)) {
      result.add(video);
    }
  }
  result.shuffle();
  return result;
}

// void addToPlaylist(PlayListModel value)async{

//    playListnotifier.value.add(value);
//     playListnotifier.notifyListeners();
//     print('added');

// }
getAllPlayListFromDb() async {
  final playlistDB = await Hive.openBox<Playlist>('playlist_db');
  playListnotifier.value.clear();
  playListnotifier.value.addAll(playlistDB.values);
  playListnotifier.notifyListeners();
}

// List<AssetEntity> getAssetsFromIds(List<String> ids) {
//   final List<AssetEntity> assets = [];
//   for (String id in ids) {
//     final AssetEntity asset = AssetEntity.fromId(id) as AssetEntity;
//     assets.add(asset);
//   }
//   return assets;
// }
List<AssetEntity> getAssetsFromIds(
    List<AssetEntity> allVideos, List<String> ids) {
  List<AssetEntity> playlistVideos = [];

  for (String id in ids) {
    AssetEntity? video = allVideos.firstWhere((video) => video.id == id);
    playlistVideos.add(video);
  }

  return playlistVideos;
}
