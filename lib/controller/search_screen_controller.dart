import 'package:api_integration_3/model/home_screen/all_news_res_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  AllNewsResDataModel? allNewsResDataModel;
  bool isLoading = true;
  Future<void> getEverything(String query) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&apiKey=69fe150ba3c646c4b3a739067acef94c");
    var responseEverything = await http.get(url);

    print(responseEverything.statusCode);
    print(responseEverything.body);

    if (responseEverything.statusCode == 200) {
      allNewsResDataModel =
          allNewsResDataModelFromJson(responseEverything.body);
    }
    isLoading = false;
    notifyListeners();
  }
}
