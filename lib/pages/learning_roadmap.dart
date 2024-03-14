import 'package:flutter/material.dart';

import '../components/circle_avatar.dart';

class LearningRoadmapPage extends StatefulWidget {
  @override
  State<LearningRoadmapPage> createState() => _LearningRoadmapPageState();
}

class _LearningRoadmapPageState extends State<LearningRoadmapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(
            'Introduction to Python',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 1.5),
          )),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          Container(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                unit('Start of Unit 1'),
                const SizedBox(height: 30),
                const CircleAvatarIndicator(Color.fromRGBO(143, 148, 251, 1),
                    "assets/star.png", 'What is Python?', 200),
                CircleAvatarIndicator(Color.fromRGBO(143, 148, 251, 1),
                    "assets/star.png", 'Hello World!', 50),
                CircleAvatarIndicator(Color.fromRGBO(143, 148, 251, 1),
                    "assets/star.png", 'Variables & Types', 0),
                CircleAvatarIndicator(Color.fromRGBO(143, 148, 251, 0.3),
                    "assets/star.png", 'Objects & Classes', 50),
                const CircleAvatarIndicator(Color.fromRGBO(143, 148, 251, 0.3),
                    "assets/star.png", 'Complex Functions', 50),
                unit('End of Unit 1')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget unit(String txt) {
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

class _LanguageTile extends StatelessWidget {
  final String language;
  final IconData icon;
  final double progress;

  const _LanguageTile({
    Key? key,
    required this.language,
    required this.icon,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(language),
      subtitle: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[300],
        valueColor:
            AlwaysStoppedAnimation<Color>(Color.fromRGBO(143, 148, 251, 1)),
      ),
      trailing: Text('${(progress * 100).toInt()}%'),
      onTap: () {
        // Handle tile tap
      },
    );
  }
}
