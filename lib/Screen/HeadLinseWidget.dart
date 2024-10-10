import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/API/News_API.dart';
import 'package:news_app/Model/NewsHeadLinesModel.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Screen/News_Detail.dart';

class Headlinsewidget extends StatefulWidget {
  const Headlinsewidget({super.key});

  @override
  State<Headlinsewidget> createState() => _HeadlinsewidgetState();
}

class _HeadlinsewidgetState extends State<Headlinsewidget> {
  final NewsApi _newsApi = NewsApi();
  DateFormat dateFormates = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return SizedBox(
      height: height * .45,
      width: width,
      child: FutureBuilder<NewHeadLinesModel>(
        future: _newsApi.getNewHeadLines(),
        builder: (context, AsyncSnapshot<NewHeadLinesModel> snapshot) {
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
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            new_scr:
                                snapshot.data?.articles?[index].source?.name ??
                                    "No Updates",
                            NewsImg: snapshot.data!.articles![index].urlToImage
                                .toString(),
                            NewTitile: snapshot.data!.articles![index].title
                                .toString(),
                            New_Dics: snapshot
                                .data!.articles![index].description
                                .toString(),
                            new_publish: snapshot
                                .data!.articles![index].publishedAt
                                .toString(),
                            NewAuth: snapshot.data!.articles![index].author
                                .toString(),
                            New_Content: snapshot.data!.articles![index].content
                                .toString(),
                          ),
                        ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: height * .6,
                        width: width * .9,
                        padding: EdgeInsets.symmetric(
                          horizontal: height * .02,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data!.articles![index].urlToImage
                                .toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Container(
                                child: const SpinKitFadingCircle(
                                  color: Colors.blueAccent,
                                  size: 50,
                                ),
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
                      ),
                      Positioned(
                        bottom: 20,
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.all(15),
                            height: height * 0.22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * .7,
                                  child: Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: width * .7,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        maxLines: 2,
                                        //overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        DateFormat('yyyy-MMM-dd HH:mm').format(
                                            DateTime.parse(snapshot.data!
                                                .articles![index].publishedAt
                                                .toString())),
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .ellipsis, // If you want to show an ellipsis
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
