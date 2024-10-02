import 'package:api_integration_3/model/save_screen_model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsDetailScreenController with ChangeNotifier {
  final saveBox = Hive.box<SaveModel>("newsBox");

  List keys = [];

  Future<void> onSave(
      {required String title,
      required String description,
      String? image,
      required String date,
      required String author}) async {
    await saveBox.add(SaveModel(
        title: title,
        description: description,
        date: date,
        author: author,
        image: image));
  }

  getSavedNews() {
    keys = saveBox.keys.toList();
    notifyListeners();
  }

  SaveModel? getCurrentSaved(var key) {
    final currentSaved = saveBox.get(key);
    return currentSaved;
  }
}
