import 'package:flex_education/components/electric_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/course.dart';

class PostDetails extends StatefulWidget {
  final Course course;
  const PostDetails({required this.course});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        //the Stack widgets displayes its children one over the other
        child: Stack(children: [
          //on the bbackground, it is shown the thumbnail
          Positioned(
            left: 0,
            right: 0,
            child: Hero(
              tag: 1,
              child: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.course.thumbnail),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          //On the foregorund, it is displayed a DraggableScrollableSheet
          Positioned.fill(
            top: 0,
            child: CustomDraggableScrollableSheet(
              width: double.maxFinite,
              course: widget.course,
            ),
          )
        ]),
      ),
    );
  }
}

class CustomDraggableScrollableSheet extends StatefulWidget {
  final double width; // Define the variable
  final Course course;
  CustomDraggableScrollableSheet({required this.width, required this.course});
  @override
  State<CustomDraggableScrollableSheet> createState() =>
      _CustomDraggableScrollableSheetState();
}

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  var _isInit = true;
  var circularRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      //the onNotification function is called whenever the user scrolls the DraggableScrollableSheet.
      onNotification: (DraggableScrollableNotification dsNotification) {
        //the circularRadius defines how much the corners of the sheet are rounded.
        //If the user is going to completely open the sheet, occupying all the screen, these corners gradually loose all their 'roundness'.
        if (dsNotification.extent >= 0.90 && dsNotification.extent < 0.98) {
          setState(() {
            circularRadius = 15;
          });
        }
        if (dsNotification.extent >= 0.98) {
          setState(() {
            circularRadius = 0;
          });
        }
        return true;
      },
      child: DraggableScrollableSheet(
          initialChildSize: 0.63,
          //the sheet never goes lower than the initial size
          minChildSize: 0.63,
          builder: (ctx, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(circularRadius),
                      topRight: Radius.circular(circularRadius))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(children: [
                  Container(
                      width: widget.width * 0.1,
                      margin: const EdgeInsets.only(
                          bottom: 10, top: 6, right: 70, left: 70),
                      child:
                          const Divider(color: Colors.black54, thickness: 2)),
                  //starting from here, all the detailed information are displayed.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          //the title
                          widget.course.title,
                          style: const TextStyle(
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Creator',
                            style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          //the author of the post
                          Text('jacopo_04',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 129, 133, 240))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.language,
                            color: Color.fromARGB(255, 129, 133, 240),
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            //the name of the location
                            widget.course.language,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.date_range_rounded,
                            color: Color.fromARGB(255, 129, 133, 240),
                            size: 24,
                          ),
                        ),
                        Text(
                          //the date of the event
                          'March 14, 2024',
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  //the following row contains Consumers as its children are the like button, and the text with the number of likes. Thus, they change when the user clicks on the button
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'This event is liked by ',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: "${widget.course.likes}",
                                    style: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 129, 133, 240)))
                              ]),
                        ),
                        //this is the exact same button, and works the exact same way, as the like button in the post card
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red,
                          ),
                        ),
                      ]),
                  //the same is true for the participate button. It is the same widget as the on edisplayed on the post card
                  Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ElectricButton(
                        buttonPressed: () {},
                        title: 'Enroll',
                        color: Color.fromARGB(255, 129, 133, 240),
                      )),
                  //from here, the information which have to be retrieved from the database are displayed
                  SizedBox(
                      width: double.maxFinite,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'Enrolled \n', //Participants
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text:
                                            'To this event participate ', //{numParticipants} participate in this event
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                    TextSpan(
                                        text: "${widget.course.enrolled} \n",
                                        style: const TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 129, 133, 240),
                                            height: 1.8,
                                            fontSize: 15)),
                                    //maxParticipants - numParticipants = remaining seats
                                    TextSpan(
                                        text: '100'.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 129, 133, 240),
                                            height: 1.8,
                                            fontSize: 15)),
                                    const TextSpan(
                                        text:
                                            ' available seats \n', //Available seats
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          height: 1.8,
                                        )),
                                    const TextSpan(
                                        text: ' among enrolled',
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w400,
                                            height: 1.8,
                                            fontSize: 15))
                                  ],
                                )),
                            //if there are participants who are also followed by the user, a horizontal ListView is shown
                            //Requirements
                            SizedBox(
                              width: double.maxFinite,
                              child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'Requirements \n',
                                    style: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        height: 1.8,
                                        fontSize: 22),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.course.requirements,
                                          style: const TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            height: 1.2,
                                          )),
                                    ],
                                  )),
                            ),
                            //The whole description
                            SizedBox(
                              width: double.maxFinite,
                              child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: 'Description \n',
                                    style: const TextStyle(
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        height: 1.8,
                                        fontSize: 22),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.course.description,
                                          style: const TextStyle(
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            height: 1.2,
                                          )),
                                    ],
                                  )),
                            ),
                            //An horizontal ListView is used to display additional images
                            Container(
                              width: double.maxFinite,
                              height: 300,
                              margin:
                                  const EdgeInsets.only(top: 17, bottom: 30),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: (context, index) => Container(
                                  width: 200,
                                  height: 300,
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 12),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 177, 174, 174)
                                            .withAlpha(60),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        index == 0
                                            ? widget.course.photo1
                                            : widget.course.photo2,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                          ])),
                ]),
              ),
            );
          }),
    );
  }
}
