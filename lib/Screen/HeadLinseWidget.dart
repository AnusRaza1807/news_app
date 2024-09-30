import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/API/News_API.dart';
import 'package:news_app/Model/NewsHeadLinesModel.dart';

class Headlinsewidget extends StatefulWidget {
  const Headlinsewidget({super.key});

  @override
  State<Headlinsewidget> createState() => _HeadlinsewidgetState();
}

class _HeadlinsewidgetState extends State<Headlinsewidget> {
  final NewsApi _newsApi = NewsApi();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return SizedBox(
      height: height * .55,
      width: width,
      child: FutureBuilder<NewHeadLinesModel>(
        future: _newsApi.getNewHeadLines(),
        builder: (context, AsyncSnapshot<NewHeadLinesModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
                return Stack(
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
                              child: SpinKitFadingCircle(
                                color: Colors.blueAccent,
                                size: 50,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Icon(
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
                          padding: EdgeInsets.all(15),
                          height: height * 0.22,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width * .7,
                                child: Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              Container(
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
                                      snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      maxLines: 2,
                                      //overflow: TextOverflow.ellipsis,
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
