import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stick/constains/colors.dart';
import 'package:stick/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  String? title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Text(
              "Creation Community",
              style: TextStyle(
                fontFamily: 'Harlow',
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Align(
                    heightFactor: 0.5,
                    widthFactor: 0,
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      height: 15,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: primaryInputColor,
                  filled: true,
                  hintText: "Поиск",
                  hintStyle: const TextStyle(
                    color: primaryInputTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('articles').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text("Нет записей");
              }
              return SizedBox(
                height: snapshot.data!.docs.length * 1000,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(snapshot.data!.docs[index].get('title'));
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                  body: DetailScreen(
                                      authorName: snapshot.data!.docs[index]
                                          .get('author_name'),
                                      title: snapshot.data!.docs[index]
                                          .get('title'),
                                      description: snapshot.data!.docs[index]
                                          .get('description'),
                                      uid:
                                          snapshot.data!.docs[index].get('uid'),
                                      id: snapshot.data!.docs[index].get('id'),
                                      url: snapshot.data!.docs[index]
                                          .get('url'))),
                            ),
                            // (route) => false,
                          );
                          return;
                        },
                        child: Image.network(
                          snapshot.data!.docs[index].get('url'),

                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.45,
                          fit: BoxFit.cover,
                          // width: MediaQuery.of(context).size.width * 0.45,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
