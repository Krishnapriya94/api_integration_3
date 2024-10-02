import 'package:api_integration_3/model/home_screen/all_news_res_data_model.dart';
import 'package:api_integration_3/model/home_screen/news_res_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  NewsResDataModel? newsResData;

  bool isLoading = false;

  int? selectedIndex;

  Future<void> getTopHeadLines() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=c655201135cc4275b9b11dd0966b9a7c");

    var responseHeadlines = await http.get(url);
    print(responseHeadlines.statusCode);
    print(responseHeadlines.body);

    if (responseHeadlines.statusCode == 200) {
      newsResData = newsResDataModelFromJson(responseHeadlines.body);
    }
    isLoading = false;
    notifyListeners();
  }
}
