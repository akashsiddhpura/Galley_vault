import 'dart:io';

import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';

String durationToString(int seconds) {
  int minutes = (seconds / 60).floor();
  int remainingSeconds = seconds % 60;
  int? hrs;
  int? remainingMinutes;
  if (seconds >= 3600) {
    hrs = (minutes / 60).floor();
    remainingMinutes = minutes % 60;
    return "$hrs:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }
  return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
}

String formatDateTime(DateTime dateTime) {
  return DateFormat("d MMM y").format(dateTime);
}

String formatFileSize(int fileSize) {
  double sizeInMB = fileSize / (1024 * 1024);
  return sizeInMB.toStringAsFixed(1) + " MB";
}

class FileDetails {
  String dateTime;
  String fileSize;

  FileDetails({
    required this.dateTime,
    required this.fileSize,
  });
}

Future<FileDetails> getFileDetails(AssetEntity assetEntity) async {
  // Get file properties
  File? file = await assetEntity.file;
  final fileStat = await file?.stat();
  final DateTime dateTime = fileStat!.modified;
  final int fileSize = fileStat.size;

  String formattedDateTime = formatDateTime(dateTime);
  String formattedFileSize = formatFileSize(fileSize);

  return FileDetails(
    dateTime: formattedDateTime,
    fileSize: formattedFileSize,
  );
}

//  children: [//SizedBox(
// //   width: MediaQuery.of(context).size.width / 6,
// //   height: 70,
// //    child: TextButton(onPressed: (){
// //            final sortOption=widget.assets..sort((a, b) => a.duration.compareTo(b.duration));
// //             setState(() {
// //               widget.assets=sortOption;
// //             });
// //              _scrollController.animateTo(0,
// //              duration: const Duration(milliseconds: 2000),
// //              curve: Curves.slowMiddle
// //              );
// //     }, child: const Text('sort by duration')),
// //  ),
// //   SizedBox(
// //      width: MediaQuery.of(context).size.width / 6,
// //      height: 70,
// //     child: TextButton(onPressed: (){
// //      final sortOption=widget.assets..sort((a, b) => a.title!.compareTo(b.title!));
// //         setState(() {
// //           widget.assets=sortOption;
// //         });
// //         _scrollController.jumpTo(0.0);
// //     }, child: const Text('Sort by Name')),
// //   ),
//   //    SizedBox(
//   //    width: MediaQuery.of(context).size.width / 6,
//   //    height: 70,
//   //   child: TextButton(onPressed: (){
//   //    final sortOption=widget.assets..sort((a, b) => b.createDateTime.compareTo(a.createDateTime));

//   //       setState(() {
//   //         widget.assets=sortOption;
//   //       });
//   //      _scrollController.jumpTo(0.0);
//   //   }, child: const Text('Sort by date')),
//   // ),
//   //    SizedBox(
//   //    width: MediaQuery.of(context).size.width / 6,
//   //    height: 70,
//   //   child: TextButton(onPressed: (){
//   //    final sortOption=widget.assets..sort((a, b) => b.size.toString().compareTo(a.size.toString()));
//   //       setState(() {
//   //         widget.assets=sortOption;
//   //       });
//   //      _scrollController.jumpTo(0.0);
//   //   }, child: const Text('Sort by size')),
//   // ),
//   //   SizedBox(
//   //    width: MediaQuery.of(context).size.width / 6,
//   //    height: 70,
//   //   child: IconButton(onPressed: (){
//   //   _scrollController.jumpTo(0.0);
//   //   toggleView();
//   //   },
//   //   icon: Icon( isGridView ? Icons.list : Icons.grid_on,color: Colors.white),
//   //    ),
//   // ),
//   //   SizedBox(
//   //    width: MediaQuery.of(context).size.width / 6,
//   //    height: 70,
//   //   child: TextButton(onPressed: (){

//   //       setState(() {
//   //      //   widgetGettingCalled=widgetToCall;
//   //       });
//   //      _scrollController.jumpTo(0.0);
//   //   }, child: const Text('listview')),
//   // )

//   ]),
