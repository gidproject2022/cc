import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text("Log Out"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          Text(user!.email!),
          Text(user!.uid),
          Text(user!.toString()),
        ],
      ),
    );
  }
}
