import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/API/News_API.dart';
import 'package:news_app/Model/NewsHeadLinesModel.dart';
import 'package:news_app/Screen/CategoriesScreen.dart';
import 'package:news_app/Screen/HeadLinseWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  NewsApi _newsApi = NewsApi();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
        appBar: AppBar(
          title: Text("News App"),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Categoriesscreen()));
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Headlinsewidget(),
          ],
        ));
  }
}
