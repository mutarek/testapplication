import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'customObjects/posts.dart';

Future createPost(String url, {required Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}

class MyApp extends StatelessWidget {
  late final Future post;
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: [
                new TextField(
                  controller: titleControler,
                  decoration: InputDecoration(
                      hintText: "title....", labelText: 'Post Title'),
                ),
                new TextField(
                  controller: bodyControler,
                  decoration: InputDecoration(
                      hintText: "body....", labelText: 'Post Body'),
                ),
                new RaisedButton(
                  onPressed: () async {
                    Post newPost = new Post(
                        userId: "123",
                        id: 0,
                        title: titleControler.text,
                        body: bodyControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.title);
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}

void main() => runApp(MyApp());
