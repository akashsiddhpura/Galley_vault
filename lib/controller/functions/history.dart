// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

import 'global_variables.dart';

class HistoryVideos {
  static ValueNotifier<List<AssetEntity>> historyVideoNotifier =
      ValueNotifier([]);
  static List<dynamic> historyLists = [];

  static Future<void> addToHistory(AssetEntity item) async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    await historyDB.add(item.id);
    getHistoryVideos();
    historyVideoNotifier.notifyListeners();
  }

  static Future<void> removeFromHistory(AssetEntity item) async {
    int deleteKey = 0;
    final historyDB = await Hive.openBox<String>('videoHistory');
    final Map<dynamic, String> historyMap = historyDB.toMap();
    historyMap.forEach((key, value) {
      if (value == item.id) {
        deleteKey = key;
      }
    });
    historyDB.delete(deleteKey);
    historyVideoNotifier.value.removeWhere((asset) => asset.id == item.id);
    // await historyDB.delete(item.id);
    // historyLists.remove(item);
    // historyVideoNotifier.value.remove(item);
    historyVideoNotifier.notifyListeners();
  }

  static Future<void> getHistoryVideos() async {
    final historyDB = await Hive.openBox<String>('videoHistory');
  
    historyLists = historyDB.values.toList();
    displayHistory();
    historyVideoNotifier.notifyListeners();
  }

  static Future<dynamic> displayHistory() async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    final historyVideos = historyDB.values.toList();
    historyVideoNotifier.value.clear();
    historyLists.clear();
    for (int i = 0; i < historyVideos.length; i++) {
      for (int j = 0; j < theallRecentListFortheSelectionPage.length; j++) {
        if (historyVideos[i] == theallRecentListFortheSelectionPage[j].id) {
          historyVideoNotifier.value
              .add(theallRecentListFortheSelectionPage[j]);
          historyLists.add(theallRecentListFortheSelectionPage[j].id);
        }
      }
    }
    return historyLists;
  }

  static Future<void> clearHistory() async {
    final historyDB = await Hive.openBox<String>('videoHistory');
    await historyDB.clear();
    historyVideoNotifier.value.clear();
    historyLists.clear();
    historyVideoNotifier.notifyListeners();
  }

  static Future<bool> openHistoryBox()async{
    bool emptyOrNOt=true;
   final historyDB = await Hive.openBox<String>('videoHistory');
   if (historyDB.values.isNotEmpty) {
   
      emptyOrNOt=false;
   }
   return emptyOrNOt;
   
  }


}
