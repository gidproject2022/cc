import 'package:flutter/material.dart';
import 'package:stick/constains/colors.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key? key,
    required final this.authorName,
    required final this.title,
    required final this.description,
    required final this.url,
    required final this.uid,
    required final this.id,
  }) : super(key: key);

  String? authorName;
  String? title;
  String? description;
  String? url;
  String? uid;
  int? id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Image.network(
              widget.url!,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            alignment: Alignment.topCenter,
            color: primaryWhiteColor,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: primaryGreyColor,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      height: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.title!,
                            style: const TextStyle(
                              fontFamily: 'Century Gothic Bold',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            widget.authorName!,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.description!,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          color: additionalPinkColor,
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
