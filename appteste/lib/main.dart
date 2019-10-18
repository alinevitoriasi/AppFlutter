import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
    runApp(MinhaApp());
}

class MinhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    List data;
    Future<String> getJSONData() async {
      final String url = "https://unsplash.com/napi/photos/Q14J2k8VE3U/related";

      var response = await http.get(url);
      
       data= json.decode(response.body)['results'];
      print(data);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LinCar'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: _listView(),
    );
  }

_listView(){
  return ListView.builder(
    itemCount: data ==null?0: data.length,
    itemBuilder: (context,index){
      return _exibirImagem(data[index]);
    }
    );
}
 _exibirImagem(dynamic item)=> Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: item['urls']['small'],
            )
          ],
      ),
 );


  @override
  void initState(){
    super.initState();
    this.getJSONData();
  }
}

class _exibirImagem {
}