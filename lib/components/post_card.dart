import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_education/components/electric_button.dart';
import 'package:flex_education/pages/post_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../pages/quiz_page.dart';
import '../services/firebase_provider.dart';

class PostCard extends StatelessWidget {
  final Course course;
  PostCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetails(
                    course: course,
                  )),
        );
      },
      //to simplify and make more efficient the widget, all the parts of the card are divided in three widgets
      child: Column(children: [
        Up(course: course),
        CentralImage(course: course),
        Bottom(course: course),
      ]),
    );
  }
}

class Up extends StatelessWidget {
  final Course course;
  Up({required this.course});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      //when clicked, if the post does not belong to the current user, the ProfilePage of the author of the post is shown
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5, right: 12, left: width * 0.03),
            child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(course.profilePicture)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(course.username,
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 17,
                    fontWeight: FontWeight.w500)),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(bottom: 14, right: 10),
            child: PopupMenuButton(
              child: const Icon(
                Icons.more_vert,
                color: Colors.black87,
              ),
              // the post author is the current user, the three dots, when clicked, will show a button to delete the post.
              // Otherwise, a button to report the post is shown
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Report',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    var res = 'Post eliminato';
                    try {} catch (err) {
                      res = 'Impossible to delete the post, try later';
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CentralImage extends StatelessWidget {
  final Course course;
  CentralImage({required this.course});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //to display the title in a consistent way, containerWidth is adjusted according to the length of the title
    final containerWidth = width - 20;
    return Stack(
      //the title is positioned above the thumbnail thanks to the Stack and Positioned widgets
      children: [
        SizedBox(
          height: width * 0.68,
          width: width,
          child: Hero(
              tag: 1,
              child: Image.network(course.thumbnail, fit: BoxFit.cover)),
        ),
        Positioned(
            bottom: 10,
            left: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  //height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    course.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class Bottom extends StatefulWidget {
  final Course course;
  Bottom({required this.course});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late bool isLiked;
  late bool isEnrolled;

  @override
  void initState() {
    super.initState();
    isLiked = widget.course.isLiked;
    isEnrolled = widget.course.isEnrolled;
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final height = MediaQuery.of(context).size.height * 0.07;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, top: 15, right: 10, left: 13),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                                Provider.of<MyProvider>(context, listen: false)
                                    .likeCourse(widget.course.courseId);
                              },
                              icon: Icon(
                                isLiked
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: isLiked ? Colors.red : Colors.black,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.comment_outlined,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.share,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElectricButton(
              buttonPressed: () {
                setState(() {
                  isEnrolled = !isEnrolled;
                });
                Provider.of<MyProvider>(context, listen: false)
                    .enrollCourse(widget.course.courseId);
                if (widget.course.isEnrolled == true) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Adjust Course to your level'),
                      content: Text(
                          'Take a quick quiz to caliber the level of the course'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizPage()),
                            );
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
              },
              color: isEnrolled
                  ? Color.fromARGB(255, 83, 88, 233)
                  : Color.fromARGB(255, 129, 133, 240),
              title: isEnrolled ? 'Enrolled' : 'Enroll',
            )
          ],
        ),
        //a short version of the description is shown.
        Container(
          width: double.maxFinite,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.course.description,
            style: const TextStyle(fontFamily: 'Ubuntu', fontSize: 14),
            //when the description overflows the available space, three dots are shown thanks to the TextOverflow.ellipsis enum value
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
