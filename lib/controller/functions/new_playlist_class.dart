// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:hive_flutter/hive_flutter.dart';
part 'new_playlist_class.g.dart';

@HiveType(typeId: 1)
class Playlist extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  List<String> videoIds;
  // final ValueNotifier<List<String>> videoIds;

  Playlist({required this.name, required this.videoIds});

  add(String id) async {
    videoIds.add(id);
    save();
  }

  deleteData(String id) {
    videoIds.remove(id);
    save();
  }

  bool isValueIn(String id) {
    return videoIds.contains(id);
  }

  addOrRemoveVideo(String videoId) {
    if (videoIds.contains(videoId)) {
      videoIds.remove(videoId);
    } else {
      videoIds.add(videoId);
    }
  }

  // ValueNotifier<List<String>>videoIdNotifier=ValueNotifier([]);

  // ValueNotifier<List<AssetEntity>>playlistVideosNotifier=ValueNotifier([]);

//    addToTheAssetPLaylist({required id})async{
//   final video= await AssetEntity.fromId(id);
//   if (!playlistVideosNotifier.value.contains(video)) {
//   playlistVideosNotifier.value.add(video!);
//   // ignore: invalid_use_of_protected_member
//   playlistVideosNotifier.notifyListeners();
// }else{
//    playlistVideosNotifier.value.remove(video!);
//   // invalid_use_of_visible_for_testing_member
//   // ignore: invalid_use_of_protected_member
//   playlistVideosNotifier.notifyListeners();

// }

}
