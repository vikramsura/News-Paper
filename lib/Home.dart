
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:untitled12/Login.dart';
import 'package:untitled12/News.dart';
import 'package:untitled12/all.dart';
import 'package:untitled12/news_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  List<Articles> articleList = [];

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    var apiUrl =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=993a52977efd4711883137a3e13b3343";
    Uri myUri = Uri.parse(apiUrl);
    Response response = await get(myUri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      NewsModel newsModel = NewsModel.fromJson(jsonResponse);
      List<Articles> list = newsModel.articles!;
      articleList.addAll(list);
      setState(() {
        isLoading = false;
      });
    } else {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.Color1),
          backgroundColor: AppColors.Color2,
          toolbarHeight: 80,
          centerTitle: true,
          surfaceTintColor: AppColors.Color2,
          titleSpacing: 0,
          title: Image.asset(
            'assets/new1.jpg',
            width: MediaQuery.of(context).size.width/1.5,
          ),
        ),
        drawer: Drawer(
          surfaceTintColor: AppColors.Color3,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        child: Image.network(
                          UserDetails.photo.toString() == "null"
                              ? "https://freepngimg.com/save/10955-cartoon-transparent/344x395"
                              : UserDetails.photo!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    ListTile(
                      leading: Icon(Icons.person,size: 30,),
                      title: Text('User : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        UserDetails.userPhone.toString() == "null"
                            ? "User Phone"
                            : UserDetails.userPhone!,
                        style: TextStyle(
                          color: AppColors.Color1,
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                        onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Do you Want to Logout?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () async {
                                    await clearUserDetails();
                                    Fluttertoast.showToast(
                                        msg: "User Logout successfully");
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Text("Yes")),
                            ],
                          );
                        },
                      );
                    }, child: Text("Logout"))
                  ]),
            ),
          ),
        ),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.separated(
                  itemCount: articleList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          foregroundColor: AppColors.Color2,
                          autoClose: true,
                          backgroundColor: AppColors.Color1,
                          icon: Icons.bookmark_border_rounded,
                          label: 'Save',
                          onPressed: (context) => News,
                        )
                      ]),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => News(
                                  articles: articleList[index],
                                ),
                              ));
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    articleList[index].urlToImage == null
                                        ? 'https://static.javatpoint.com/top10-technologies/images/top-10-english-newspapers-in-india3.png'
                                        : articleList[index].urlToImage!,
                                    height: MediaQuery.of(context).size.height -
                                        500,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Text(
                                    articleList[index].title!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.Color1),
                                  ),
                                  Text(
                                    articleList[index].source!.name!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: AppColors.Color3, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      thickness: 2,
      height: 20,
    );
  }
}
