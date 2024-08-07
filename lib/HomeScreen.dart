import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/NestedObjectApi.dart';

import 'Models/PostsModel.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostsApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      postList = data.map((json) => PostsModel.fromJson(json)).toList();
      return postList;
    } else {
      return [];
    }
  }
  Future<List<PostsModel>> getUser() async {
    List<PostsModel> userList = [];
    try {
      final response = await http.get(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userJsonList = data['data'];

        userList = userJsonList.map((userJson) => PostsModel.fromJson(userJson))
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
      appBar: AppBar(
        title: const Text('GET API'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getPostsApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      PostsModel post = postList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration:
                            BoxDecoration(color: Colors.blueAccent.shade100),
                        child: ListTile(
                          title: Text(post.title ?? ''),
                          subtitle: Text(post.body ?? ''),
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
                  builder: (context) => NestedObjectApi(),
                ));
              },
              child: Text('NEXT API'))
        ],
      ),
    );
  }
}
