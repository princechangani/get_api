import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/PhotosApi.dart';
import 'package:get_api/UserModel.dart';
import 'package:http/http.dart' as http;

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  List<Results> userList = [];

  Future<List<Results>> getUser() async {
    try {
      final response = await http.get(
          Uri.parse("https://randomuser.me/api/0.8/?results=10"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userJsonList = data['results'];

        userList = userJsonList.map((userJson) => Results.fromJson(userJson))
            .toList();
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder<List<Results>>(
            future:getUser (),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      Results user = userList[index];
                      return ListTile(
                        title: Text(user.user?.name?.first??""),
                        subtitle: Text(index.toString()),
                        );

                    },
                  ),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PhotosApi(),
              ));
            },
            child: Text('NEXT API'),
          ),
        ],
      ),
    );
  }
}
