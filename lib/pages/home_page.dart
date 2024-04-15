import 'package:flex_education/pages/learning_roadmap.dart';
import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<MyProvider>(context, listen: false).getEnrolledCourse(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final courseData =
              Provider.of<MyProvider>(context, listen: false).courseData;
          if (courseData == null || courseData.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.only(left: 7, bottom: 5),
                  child: Text(
                    'Enroll in a Course',
                    style: TextStyle(fontSize: 22, letterSpacing: 1.5),
                  ),
                ),
                centerTitle: false,
                backgroundColor: Color.fromARGB(255, 129, 133, 240),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
            );
          }
          final unitsData = (snapshot.data as List);
          var firstUnit;
          switch (courseData!['level']) {
            case 'begginer':
              firstUnit = unitsData[1];
              break;
            case 'intermediate':
              firstUnit = unitsData[2];
              break;
            case 'expert':
              firstUnit = unitsData[3];
              break;
            default:
              firstUnit = unitsData[1];
          }

          final units = [firstUnit] + unitsData.sublist(4, 12);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 7, bottom: 5),
                child: Text(
                  courseData['title'],
                  style: TextStyle(fontSize: 22, letterSpacing: 1.5),
                ),
              ),
              centerTitle: false,
              backgroundColor: Color.fromARGB(255, 129, 133, 240),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            body: LearningRoadmapPage(units),
          );
        }
      },
    );
  }
}
