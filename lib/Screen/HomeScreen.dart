import 'package:flutter/material.dart';
import 'package:news_app/Screen/CategoriesScreen.dart';
import 'package:news_app/Screen/HeadLinseWidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Categoriesscreen()));
              },
            )
          ],
        ),
        body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Headlinsewidget(),
          ],
        ));
  }
}
