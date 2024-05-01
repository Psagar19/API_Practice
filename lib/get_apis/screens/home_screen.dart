import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApis () async{
    final reposne = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(reposne.body.toString());
    if(reposne.statusCode == 200){
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APIs"),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApis(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return const Text('Loading.....');
                  }else{
                      return ListView.builder(
                        itemCount: postList.length,
                          itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(postList[index].body.toString()),
                                Text(postList[index].title.toString()),
                              ],
                            ),
                          );
                          },);
                  }
                },
            ),
          )
        ],
      ),
    );
  }
}
