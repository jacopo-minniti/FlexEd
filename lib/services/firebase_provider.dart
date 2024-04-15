import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class MyProvider with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  var userData = {};
  Map<String, dynamic>? courseData = {};
  var userIsNull = true;

  void likeCourse(courseId) async {
    final coursesLiked = userData["courses_liked"];
    var newCoursesLiked = "";
    if (coursesLiked.contains(courseId)) {
      newCoursesLiked = coursesLiked.replaceAll(courseId, '');
    } else {
      newCoursesLiked = coursesLiked + courseId;
    }
    userData["courses_liked"] = newCoursesLiked;
    print(newCoursesLiked);
    print(courseId);
    await db
        .collection("users")
        .doc(userData['id'])
        .update({"courses_liked": newCoursesLiked});
  }

  void enrollCourse(courseId) async {
    final coursesEnrolled = userData["courses_enrolled"];
    var newCoursesEnrolled = "";
    if (coursesEnrolled.contains(courseId)) {
      newCoursesEnrolled = coursesEnrolled.replaceAll(courseId, '');
    } else {
      newCoursesEnrolled = coursesEnrolled + courseId;
    }
    userData["courses_enrolled"] = newCoursesEnrolled;
    print(newCoursesEnrolled);
    print(courseId);
    await db
        .collection("users")
        .doc(userData['id'])
        .update({"courses_enrolled": newCoursesEnrolled});
  }

  Future<void> setLevel(String level) async {
    await db
        .collection('courses')
        .doc('0pZQfJOL5LwkC4jd6TWE')
        .update({'level': level});
  }

  Future<Course?> getLikedPosts() async {
    try {
      final post =
          await db.collection('courses').doc(userData['courses_liked']).get();
      return Course.fromMap(
          userData['courses_liked'],
          true,
          userData['courses_enrolled'].contains(userData['courses_liked']),
          post.data()!);
    } catch (Exception) {
      return null;
    }
  }

  Future<void> completeUnit(String unit) async {
    await db
        .collection('courses')
        .doc('0pZQfJOL5LwkC4jd6TWE')
        .collection('units')
        .doc(unit)
        .update({'isCompleted': true});
  }

  Future<void> write() async {
    // await db
    //     .collection('courses')
    //     .doc('0pZQfJOL5LwkC4jd6TWE')
    //     .collection('units')
    //     .doc('unit1')
    //     .update({
    //   'exam.questions': FieldValue.arrayUnion([
    //     {
    //       'question':
    //           'Which of the following is the correct way to concatenate two strings in Python?',
    //       'indexCorrect': 0,
    //       'option0': 'string1 + string2',
    //       'option1': 'string1 * string2',
    //       'option2': 'string1.concat(string2)',
    //       'option3': 'string1.join(string2)'
    //     },
    //     {
    //       'question': 'What is the purpose of the input() function in Python?',
    //       'indexCorrect': '1',
    //       'option0': 'To output data to the console',
    //       'option1': 'To read user input from the console',
    //       'option2': 'To convert data types',
    //       'option3': 'To handle exceptions'
    //     },
    //   ]),
    // });
    // await db
    //     .collection('courses')
    //     .doc('0pZQfJOL5LwkC4jd6TWE')
    //     .collection('units')
    //     .doc('unit1')
    //     .update({
    //   'exam.coding': FieldValue.arrayUnion([
    //     {
    //       'question':
    //           "Write a Python script that calculates the area of a rectangle given its length and width. Use input() to get the user's input for the length and width.",
    //       'answer':
    //           'def calculate_area():     length = float(input("Enter the length of the rectangle: "))     width = float(input("Enter the width of the rectangle: "))     area = length * width     print(f"The area of the rectangle is {area} square units.")  calculate_area()'
    //     },
    //     {
    //       'question':
    //           "Write a Python script that converts a temperature value from Celsius to Fahrenheit and vice versa. Use input() to get the user's input for the temperature and the conversion direction",
    //       'answer':
    //           'def celsius_to_fahrenheit(celsius):     return (celsius * 9/5) + 32  def fahrenheit_to_celsius(fahrenheit):     return (fahrenheit - 32) * 5/9  print("Temperature Conversion:") conversion_type = input("Enter "C" to convert Celsius to Fahrenheit or "F" to convert Fahrenheit to Celsius: ") temperature = float(input("Enter the temperature value: "))  if conversion_type.upper() == "C":     result = celsius_to_fahrenheit(temperature)     print(f"{temperature}°C is equal to {result}°F.") elif conversion_type.upper() == "F":     result = fahrenheit_to_celsius(temperature)     print(f"{temperature}°F is equal to {result}°C.") else:     print("Invalid conversion type.")',
    //     },
    //   ]),
    // });
    // final unit = await db
    //     .collection('courses')
    //     .doc('0pZQfJOL5LwkC4jd6TWE')
    //     .collection('units')
    //     .doc('unit1')
    //     .get();
  }

  Future<void> getUser() async {
    userIsNull = false;
    final email = user!.email;
    final data =
        await db.collection("users").where('email', isEqualTo: email).get();
    userData['id'] = data.docs[0].id;
    userData['email'] = data.docs[0]['email'];
    userData['courses_liked'] = data.docs[0]['courses_liked'];
    userData['courses_enrolled'] = data.docs[0]['courses_enrolled'];
    userData['courses_completed'] = data.docs[0]['courses_completed'];
    userData['profile_picture'] = data.docs[0]['profile_picture'];
    userData['username'] = data.docs[0]['username'];
  }

  Future<List> getEnrolledCourse() async {
    if (userData.isEmpty) {
      await getUser();
    }
    final courseId = userData['courses_enrolled'];
    if (courseId == '') {
      return [];
    }
    final data = await db.collection('courses').doc(courseId).get();
    courseData = data.data();
    final unitsData =
        await db.collection('courses').doc(courseId).collection('units').get();
    final units = unitsData.docs;
    return units;
  }
}
