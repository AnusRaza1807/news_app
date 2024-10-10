import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/API/News_API.dart';
import 'package:news_app/Model/CategoriesModel.dart';
import 'package:news_app/Screen/News_Detail.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
  final NewsApi _newsApi = NewsApi();
  // ignore: non_constant_identifier_names
  String CategoryName = 'general';
  List<String> btnCategory = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
    'Bitcon'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: btnCategory.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      CategoryName = btnCategory[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: CategoryName == btnCategory[index]
                                ? Colors.blueAccent
                                : Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(btnCategory[index].toString()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoriesModel>(
                future: _newsApi.getNewsCategories(CategoryName),
                builder: (context, AsyncSnapshot<CategoriesModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetail(
                                    new_scr: snapshot.data?.articles?[index]
                                            .source?.name ??
                                        "No Updates",
                                    NewsImg: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    NewTitile: snapshot
                                        .data!.articles![index].title
                                        .toString(),
                                    New_Dics: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                    new_publish: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    NewAuth: snapshot
                                        .data!.articles![index].author
                                        .toString(),
                                    New_Content: snapshot
                                        .data!.articles![index].content
                                        .toString(),
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder: (context, url) {
                                      return const SpinKitFadingCircle(
                                        color: Colors.blueAccent,
                                        size: 50,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(
                                        Icons.error_outline,
                                        color: Colors.blueAccent,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: height * .15,
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MMM-dd').format(
                                                DateTime.parse(snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString())),
                                            maxLines: 2,
                                            overflow: TextOverflow
                                                .ellipsis, // If you want to show an ellipsis
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
