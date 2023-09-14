import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../controller/functions/global_variables.dart';

class FolderSearchDelegate extends SearchDelegate<AssetPathEntity> {
  final List<AssetPathEntity> folders;
  final BuildContext context;

  FolderSearchDelegate({required this.folders, required this.context});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.grey,
        iconTheme: theme.iconTheme.copyWith(color: Colors.white),
        actionsIconTheme: theme.iconTheme.copyWith(color: Colors.white),
        toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(
            color: colorWhite,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ).titleLarge,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.grey,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: colorWhite,
      ),
      onPressed: () {
        close(context, folders[1]);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        folders.where((folder) => folder.name.contains(query)).toList();
    return buildSearchResults(context: context, query: query, results: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResults = folders
        .where(
            (asset) => asset.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.black,
      //   title: Text(query), toolbarTextStyle: const TextTheme(
      //     headline6: TextStyle(color: Colors.white),
      //   ).bodyText2, titleTextStyle: const TextTheme(
      //     headline6: TextStyle(color: Colors.white),
      //   ).headline6,
      // ),
      body: buildSearchResults(
          context: context, query: query, results: searchResults),
    );
  }
}

Widget buildSearchResults(
    {required query,
    required BuildContext context,
    required List<AssetPathEntity> results}) {
  if (results.isEmpty) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'No results found for "${query ?? 'hi'}".',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(top: 15),
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: .4, color: Colors.white))),
              child: ListTile(
                title: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    results[index].name,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => VideosFromFolder(
                  //       folder: results[index],
                  //     ),
                  //   ),
                  // );
                },
                subtitle: FutureBuilder<int>(
                  future: results[index].assetCountAsync,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '${snapshot.data!} videos',
                        style: const TextStyle(color: Colors.white),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                ),
              ),
            );
          },
        ),
      ));
}
