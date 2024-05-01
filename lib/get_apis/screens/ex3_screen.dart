import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../common/reusableRow.dart';
import '../models/UserModel.dart';


class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        print(i["name"]);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APIs Example 3"),
        centerTitle: true,
      ),
    body: Column(
      children: [
        Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator(color: Colors.red,);
              }else{
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(name: "Name", value: snapshot.data![index].name.toString()),
                            ReusableRow(name: "User Name", value: snapshot.data![index].username.toString()),
                            ReusableRow(name: "Email", value: snapshot.data![index].email.toString()),
                            ReusableRow(name: "Address", value: snapshot.data![index].address!.geo!.lat.toString()),
                          ],
                        ),
                      ),
                    );
                  },);
              }

            },))
      ],
    ),);
  }
}
