import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewsDetail extends StatefulWidget {
  String NewsImg,
      NewTitile,
      NewAuth,
      New_Dics,
      New_Content,
      new_publish,
      new_scr;
  // ignore: non_constant_identifier_names
  NewsDetail(
      {super.key,
      required this.NewAuth,
      required this.NewTitile,
      required this.New_Content,
      required this.New_Dics,
      required this.NewsImg,
      required this.new_publish,
      required this.new_scr});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.new_scr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.NewsImg,
                  fit: BoxFit.cover,
                  placeholder: (context, ulr) => const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                  ),
                )),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .45),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Text(
                  "News Title ${widget.NewTitile}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Publisher : ${widget.new_scr}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Discriptions : ${widget.New_Dics}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Content : ${widget.New_Content}"),
                SizedBox(
                  height: 10,
                ),
                Text("Auther : ${widget.NewAuth}",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
                Text(
                    "Publish Date: ${DateFormat('MMMM dd, yyyy HH:mm').format(DateTime.parse(widget.new_publish))}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
