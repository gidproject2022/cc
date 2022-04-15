import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stick/constains/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryInputColor,
      appBar: AppBar(
        leading: const Icon(Icons.verified_user_outlined),
        title: const Text("sddf"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .orderBy('createdAt', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text("Сообщений нет");
            }
            return SizedBox(
              height: snapshot.data!.docs.length * 10000,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        color: primaryOrangeColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.docs[index].get('authoremail'),
                              style: const TextStyle(
                                fontFamily: 'Century Gothic Bold',
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[index].get('messageText'),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: primaryWhiteColor,
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9 - 30,
              child: TextFormField(
                controller: messageController,
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
                  hintText: "Сообщение",
                  hintStyle: const TextStyle(
                    color: primaryInputTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection('messages').add({
                  'authoremail': user!.email,
                  'messageText': messageController.text.trim(),
                  'createdAt': FieldValue.serverTimestamp()
                });
                messageController.clear();
              },
              icon: const Icon(
                Icons.send,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
