import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> fetchPost() async {
  final response =
      await http.get('http://localhost:3333/user/5da6fdf79acebe19f90a3d32s');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Falha ao carregar um post');
  }
}

class User {
  final String id;
  final String email;
  final  int v;

  User({ this.id,
        this.email,
        this.v,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      email: json["email"],
      v: json["__v"],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<User> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LinCar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('LinCar'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(' email : ' + snapshot.data.email),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
