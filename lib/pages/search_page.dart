import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_education/components/custom_search_bar.dart';
import 'package:flex_education/components/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/course.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: const Padding(
          padding: const EdgeInsets.only(left: 7, bottom: 5),
          child: Text(
            'Explore',
            style: TextStyle(fontSize: 30, letterSpacing: 1.5),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 129, 133, 240),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomSearchBar(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<List<Course>>(
              future:
                  fetchCoursesFromFirestore(), // Replace with your Firestore fetching logic
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('No courses available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final course = snapshot.data![index];
                      return PostCard(course: course);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Course>> fetchCoursesFromFirestore() async {
    try {
      final db = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      final email = user!.email;
      final user_data =
          await db.collection("users").where('email', isEqualTo: email).get();
      final liked_courses = user_data.docs[0]['courses_liked'];
      final enrolled_courses = user_data.docs[0]['courses_enrolled'];

      final course_data = await db.collection("courses").get();
      var courses = <Course>[];
      for (var doc in course_data.docs) {
        var course = Course.fromMap(doc.id, liked_courses.contains(doc.id),
            enrolled_courses.contains(doc.id), doc.data());
        courses.add(course);
      }
      return courses;
    } catch (error) {
      print('Error fetching courses: $error');
      return <Course>[];
    }
  }
}
