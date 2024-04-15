import 'package:flex_education/components/course_title.dart';
import 'package:flutter/material.dart';

import '../components/circle_avatar.dart';

class LearningRoadmapPage extends StatefulWidget {
  final List units;
  const LearningRoadmapPage(this.units);
  @override
  State<LearningRoadmapPage> createState() => _LearningRoadmapPageState();
}

class _LearningRoadmapPageState extends State<LearningRoadmapPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              unitTitle('Unit 1'),
              const SizedBox(height: 30),
              ...widget.units
                  .sublist(0, 4)
                  .map((item) => CircleAvatarIndicator(item)),
              unitTitle('Unit 2'),
              ...widget.units
                  .sublist(4, 9)
                  .map((item) => CircleAvatarIndicator(item)),
              unitTitle('End of Course'),
            ],
          ),
        ),
      ],
    );
  }

  Widget unitTitle(String txt) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 15),
                child: Divider(
                  color: Colors.black,
                  height: 50,
                )),
          ),
          Text(
            txt,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: Divider(
                  color: Colors.black,
                  height: 50,
                )),
          ),
        ]);
  }
}
