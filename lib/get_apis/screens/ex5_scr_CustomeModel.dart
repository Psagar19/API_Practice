import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ProductsModel.dart';


class HomeScreen5 extends StatefulWidget {
  const HomeScreen5({super.key});

  @override
  State<HomeScreen5> createState() => _HomeScreen5State();
}

class _HomeScreen5State extends State<HomeScreen5> {

  Future<ProductsModel> getProductApi() async{
    final response = await http.get(Uri.parse("https://webhook.site/20ab5e37-f125-415a-80ff-e5a6828f45f1"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }else{
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("APIs Example 5"),
        centerTitle: true,
      ),
    body: Column(
      children: [
        Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductApi(),
              builder: (context, AsyncSnapshot<ProductsModel> snapshot) {
                if(!snapshot.hasData){
                  return LinearProgressIndicator();
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name.toString()),
                            subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  height: MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit:  BoxFit.cover,
                                        image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                  ),
                                ));
                              },
                            ),
                          ),
                          Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite_outlined : Icons.favorite_outline)
                        ],
                      );
                    },
                  );
                }
            },)
        )
      ],
    ),);
  }
}
