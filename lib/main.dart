import 'package:flutter/material.dart';
import 'package:get_api/HomeScreen.dart';
import 'package:get_api/NestedObjectApi.dart';
import 'package:get_api/PhotosApi.dart';
import 'package:get_api/UserDetails.dart';
import 'package:get_api/user_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserData(),
    );
  }
}
