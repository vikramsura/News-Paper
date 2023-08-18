import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled12/Home.dart';
import 'package:untitled12/Login.dart';

import 'all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

  // runApp(DevicePreview(
  //   enabled: true,
  //   tools: const [...DevicePreview.defaultTools],
  //   builder: (context) => const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;

    ThemeData _lighTheme =
        ThemeData(primarySwatch: Colors.red, brightness: Brightness.light);

    ThemeData _darkTheme =
        ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( primaryColor: AppColors.Color2),
      // theme:isSwitched ? _lighTheme : _darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    getData();
    getUserDetails();
    super.initState();
  }

  bool isUserLogin = false;

  getData() async {
    await LocalDataSaver.getUserLogin().then((value) {
      setState(() {
        value == true ? isUserLogin = true : LocalDataSaver.setUserLogin(false);

        if (value == true) {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          });
        } else {
          Future.delayed(Duration(seconds: 4), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Image.asset('assets/new.png')),
      ),
    );
  }
}
