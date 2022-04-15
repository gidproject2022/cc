import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stick/constains/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Article {
  int? articleId;
  String? title;
  String? description;
  String? url;
  String? athorName;
  String? uid;

  Article._({
    this.title,
    this.description,
    this.url,
    this.articleId,
    this.athorName,
    this.uid,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article._(
        title: json['title'],
        description: json['description'],
        url: json['url']);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final referenceDatabase = FirebaseDatabase.instance;

  final user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    database.child('articles/').onValue.listen((event) {
      final String? _title = event.snapshot.toString();
      setState(() {
        title = _title != null ? _title : 'Error';
      });
    });
  }

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
              "Моя лента",
              style: TextStyle(
                fontFamily: 'Century Gothic Bold',
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
                  ),
                  shrinkWrap: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(snapshot.data!.docs[index].get('title'));
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Card(
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
