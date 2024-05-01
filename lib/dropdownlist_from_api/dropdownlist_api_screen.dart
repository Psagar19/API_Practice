import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'dropdown_model.dart';
import 'package:http/http.dart' as http;

class DropdownListScreen extends StatefulWidget {
  const DropdownListScreen({super.key});

  @override
  State<DropdownListScreen> createState() => _DropdownListScreenState();
}

class _DropdownListScreenState extends State<DropdownListScreen> {

  Future<List<DropdownModel>> getPost()async{
    try{
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      final body = jsonDecode(response.body) as List ;

      if(response.statusCode == 200){
        return body.map((e){
          final map = e as Map<String, dynamic>;
          return DropdownModel(
            id: map['id'],
            userId: map['userId'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      }else{

      }
    }on SocketException{
      throw Exception(" No Internet ");
    }
    throw Exception("Error Fetching Data");
  }

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown List Api"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
                  future: getPost(),
                  builder: (context, AsyncSnapshot<List<DropdownModel>> snapshot) {
                    if(snapshot.hasData){
                      return DropdownButton(
                        hint: Text("Select Value"),
                          isExpanded: true,
                          icon: Icon(Icons.add_box_outlined),
                          value: selectedValue,
                          items: snapshot.data!.map((e){
                            return DropdownMenuItem(
                              value: e.id.toString(),
                                child: Text(e.id.toString())
                            );
                          }).toList(),
                          onChanged: (value) {
                          selectedValue = value;
                          setState(() {

                          });
                          },
                      );
                    }else{
                      return CircularProgressIndicator();
                    }
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
