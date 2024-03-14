import 'dart:ui';

import 'package:flex_education/components/electric_button.dart';
import 'package:flex_education/pages/post_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class PostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetails()),
        );
      },
      //to simplify and make more efficient the widget, all the parts of the card are divided in three widgets
      child: Column(children: [
        Up(),
        CentralImage(),
        Bottom(),
      ]),
    );
  }
}

class Up extends StatelessWidget {
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
            child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/profile pic.png')),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('jacopo_04',
                style: TextStyle(
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
                    try {
                      // await Provider.of<Posts>(context, listen: false)
                      //     .deletePost(post.postId);
                    } catch (err) {
                      res = 'Impossibile eliminare il post. Riprova più tardi';
                    }
                    //showCustomSnackbar(context, res);
                  },
                )
                //report post (feature to add)
                // : PopupMenuItem(
                //     padding: const EdgeInsets.only(left: 25),
                //     child: const Text(
                //       'Segnala',
                //       textAlign: TextAlign.center,
                //     ),
                //     onTap: () async {
                //       var res = 'Post segnalato con successo';
                //       try {
                //         // await Provider.of<Posts>(context, listen: false)
                //         //     .report(post.postId.toString(), currentUserId);
                //       } catch (err) {
                //         res = 'Errore. Riprova più tardi';
                //       }
                //       // showCustomSnackbar(context, res);
                //     },
                //   )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CentralImage extends StatelessWidget {
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
              child: Image.asset('assets/introduction_python.jpg',
                  fit: BoxFit.cover)),
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
                    'Introduction to Python',
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
  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  var is_liked = false;
  @override
  Widget build(BuildContext context) {
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
                                  is_liked = !is_liked;
                                });
                              },
                              icon: Icon(
                                is_liked
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: is_liked ? Colors.red : Colors.black,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.comment_outlined,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
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
              buttonPressed: () {},
              title: 'Enroll',
            )
          ],
        ),
        //a short version of the description is shown.
        Container(
          width: double.maxFinite,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Here there is the description of the Course (at least a first part of the text, the other is ellipsed)',
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
