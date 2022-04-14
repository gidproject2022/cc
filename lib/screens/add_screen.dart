import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String? singleImage;

  List<String> multipleImages = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            singleImage != null && singleImage!.isNotEmpty
                ? Image.network(
                    singleImage!,
                    height: 200,
                  )
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: () async {
                XFile? _image = await singleImagePick();
                if (_image!.path.isNotEmpty) {
                  singleImage = await uploadImage(_image);
                  setState(() {});
                }
              },
              child: const Text("Single Pick"),
            ),
            ElevatedButton(
              onPressed: () async {
                List<XFile>? _images = await multiImagePicker();
                if (_images.isNotEmpty) {
                  multipleImages = await multiImageUploader(_images);
                  setState(() {});
                }
              },
              child: const Text("Multiple Pick"),
            ),
            Wrap(
              children: multipleImages
                  .map(
                    (e) => Image.network(
                      e,
                      width: 200,
                      height: 200,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<String>> multiImageUploader(List<XFile> list) async {
  List<String> _path = [];
  for (XFile _image in list) {
    _path.add(await uploadImage(_image));
  }
  return _path;
}

Future<XFile?> singleImagePick() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<List<XFile>> multiImagePicker() async {
  List<XFile>? _images = await ImagePicker().pickMultiImage();
  if (_images != null && _images.isNotEmpty) {
    return _images;
  }
  return [];
}

Future<String> uploadImage(XFile image) async {
  Reference db = FirebaseStorage.instance.ref('images/${getImageName(image)}');
  await db.putFile(File(image.path));
  return await db.getDownloadURL();
}

String getImageName(XFile image) => image.path.split("/").last;
