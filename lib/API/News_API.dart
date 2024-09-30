import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Model/CategoriesModel.dart';
import 'package:news_app/Model/NewsHeadLinesModel.dart';

class NewsApi {
  Future<NewHeadLinesModel> getNewHeadLines() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=db2907b4ab0549bc923d744fd2c46de6");
    var response = await http.get(url);

    var responseBody = jsonDecode(response.body);
    print(responseBody);
    return NewHeadLinesModel.fromJson(responseBody);
  }

  Future<CategoriesModel> getNewsCategories(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=${category}&apiKey=db2907b4ab0549bc923d744fd2c46de6");
    var response = await http.get(url);

    var responseBody = jsonDecode(response.body);
    print(responseBody);
    return CategoriesModel.fromJson(responseBody);
  }
}
