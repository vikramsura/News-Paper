// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:untitled12/all.dart';
import 'package:untitled12/news_model.dart';

class News extends StatefulWidget {
  Articles articles;

  News({Key? key, required this.articles}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.Color1),
          backgroundColor: AppColors.Color2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(widget.articles.urlToImage==null?
                'https://static.javatpoint.com/top10-technologies/images/top-10-english-newspapers-in-india3.png':widget.articles.urlToImage.toString(),
                height: MediaQuery.of(context).size.height - 500,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.articles.title!,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Color1),
              ),
              SizedBox(
                height: 20,
              ),
                  Text(
                    widget.articles.source!.name!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Color3),
                  ),
                  Text(
                    widget.articles.publishedAt!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Color3),
                  ),
            ]),
          ),
        ),
      ),
    );
  }
}
