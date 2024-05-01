import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = true;

  Future getImage() async {
    final pickImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickImage != null) {
      image = File(pickImage.path);
      setState(() {});
    } else {
      print("no Image Selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse("https://fakestoreapi.com/products");

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = 'Static Title';

    var multipart = new http.MultipartFile('images', stream, length);

    request.files.add(multipart);

    var respone = await request.send();
    if (respone.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Image Uploaded");
    } else {
      setState(() {
        showSpinner = false;
      });
      print("Image  Uploading Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload Images"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 200,
                    color: Colors.red.shade50,
                    width: 200,
                    child: image == null
                        ? Center(
                            child: Text("Please Pick Image"),
                          )
                        : Container(
                            child: Center(
                              child: Image.file(
                                File(image!.path).absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
              ),
              SizedBox(height: 50.0),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(child: Text("Upload")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
