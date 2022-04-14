import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stick/constains/colors.dart';
import 'package:stick/screens/home_screen/populars.dart';
import 'package:stick/screens/home_screen/recomendations.dart';
import 'package:stick/screens/home_screen/subscriptions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
