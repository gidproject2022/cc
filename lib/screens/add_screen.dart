import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stick/constains/colors.dart';
import 'package:stick/main.dart';
import 'package:stick/screens/home_screen/home_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String? singleImage;

  List<String> multipleImages = [];

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

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
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.795 - 20,
              child: TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: primaryInputColor,
                  filled: true,
                  hintText: "Название",
                  hintStyle: const TextStyle(
                    color: primaryInputTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.795 - 20,
              child: TextFormField(
                controller: descriptionController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: primaryInputColor,
                  filled: true,
                  hintText: "Описание",
                  hintStyle: const TextStyle(
                    color: primaryInputTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                XFile? _image = await singleImagePick();
                if (_image!.path.isNotEmpty) {
                  singleImage = await uploadImage(_image);
                  setState(() {});
                }
              },
              child: const Text("Выбрать фото"),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance.collection('articles').add({
                    'id': Random().nextInt(1000000000),
                    'title': titleController.text.trim(),
                    'description': descriptionController.text.trim(),
                    'uid': user!.uid,
                    'author_name': user.email,
                    'url': singleImage,
                  });

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: Text("Отправлено"),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Опубликовать"),
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
