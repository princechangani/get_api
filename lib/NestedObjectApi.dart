import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/Models/NestedUser.dart';
import 'package:get_api/PhotosApi.dart';
import 'package:get_api/nested_user_response.dart';
import 'package:http/http.dart' as http;

class NestedObjectApi extends StatefulWidget {
  const NestedObjectApi({super.key});

  @override
  State<NestedObjectApi> createState() => _NestedObjectApiState();
}

class _NestedObjectApiState extends State<NestedObjectApi> {
  List<NestedUser> userList = [];
  List<NestedUserResponse> nestedList = [];

  Future<List<NestedUser>> getPostsApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      userList = data.map((json) => NestedUser.fromJson(json)).toList();

      return userList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder(
            future: getPostsApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      NestedUser user = userList[index];
                      return ListTile(
                        title: Text(user.address?.street ?? ''),
                        subtitle: Text(user.company?.name ?? ''),
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
              child: Text('NEXT API'))
        ],
      ),
    );
  }
}
