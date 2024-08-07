import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/HomeScreen.dart';
import 'package:get_api/Models/UserDetail.dart';

import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<UserDetail> postList = [];

  Future<List<UserDetail>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<dynamic> users = data['data'];
      postList = users.map((user) => UserDetail.fromJson(user)).toList();
      return postList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GET API'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      UserDetail user = postList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email ?? ''),
                          leading: Image.network(user.avatar ?? ''),
                        ),
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
                  builder: (context) => PostsScreen(),
                ));
              },
              child: Text('NEXT API'))
        ],
      ),
    );
  }
}
