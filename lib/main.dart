import 'package:api_prac/get_apis/screens/ex2_screen_customeModel.dart';
import 'package:api_prac/get_apis/screens/ex3_screen.dart';
import 'package:api_prac/get_apis/screens/ex5_scr_CustomeModel.dart';
import 'package:api_prac/get_apis/screens/home_screen.dart';
import 'package:api_prac/post_apis/screens/signup_screen.dart';
import 'package:api_prac/post_apis/screens/uploadimages.dart';
import 'package:flutter/material.dart';

import 'dropdownlist_from_api/dropdownlist_api_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DropdownListScreen(),
    );
  }
}
