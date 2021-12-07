import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_provider.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';


void clearSearchHistoryDialog(BuildContext context, SearchHistoryDatabaseProvider dbProvider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Clear All Search History'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              dbProvider.deleteAllSearchHistory();
              showSnackBar(context, 'Search History Cleared');
              inject<Navigate>().pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
