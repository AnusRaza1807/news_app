import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/API/News_API.dart';
import 'package:news_app/Model/CategoriesModel.dart';
import 'package:news_app/Screen/CategoriesScreen.dart';
import 'package:news_app/Screen/HeadLinseWidget.dart';
import 'package:news_app/Screen/News_Detail.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // ignore: non_constant_identifier_names
  String CategoryName = 'general';
  final NewsApi _newsApi = NewsApi();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Top Headlines Today",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const Headlinsewidget(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      NewsImg: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      new_scr: snapshot.data?.articles?[index]
                                              .source?.name ??
                                          "No Updates",
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
            ),
          ],
        ));
  }
}
