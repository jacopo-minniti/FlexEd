import 'package:flex_education/components/electric_button.dart';
import 'package:flex_education/pages/question_page.dart';
import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:string_unescape/string_unescape.dart';

class UnitPage extends StatelessWidget {
  final dynamic unit;
  const UnitPage({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 7, bottom: 5),
          child: Text(
            Provider.of<MyProvider>(context, listen: false)
                .courseData!['title'],
            style: TextStyle(fontSize: 22, letterSpacing: 2),
          ),
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 129, 133, 240),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            unit['title'],
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ExpansionTile(
            textColor: Color.fromRGBO(143, 148, 251, 1),
            title: Text(
              'Material',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the screen width
                child: MarkdownBody(
                  data: unescape(unit['material']),
                  onTapLink: (text, url, title) {
                    launchUrl(Uri.parse(url!));
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Key Concepts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            textColor: Color.fromRGBO(143, 148, 251, 1),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the screen width
                child: MarkdownBody(
                  data: unescape(unit['keyConcepts']),
                  onTapLink: (text, url, title) {
                    launchUrl(Uri.parse(url!));
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            textColor: Color.fromRGBO(143, 148, 251, 1),
            title: Text(
              'Tips',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the screen width
                child: MarkdownBody(
                  data: unescape(unit['tips']),
                  onTapLink: (text, url, title) {
                    launchUrl(Uri.parse(url!));
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 450,
          ),
          ElectricButton(
              buttonPressed: () {
                if (unit['isCompleted'] == true) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('You already Passed this Unit!'),
                          content: Text('Go to the next one'),
                          iconColor: const Color.fromRGBO(143, 148, 251, 1),
                          shadowColor: const Color.fromRGBO(143, 148, 251, 1),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok',
                                  style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  )),
                            ),
                          ],
                        );
                      });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuestionPage(unit)));
                }
              },
              title: 'Start Test',
              color: const Color.fromRGBO(143, 148, 251, 1)),
          SizedBox(
            height: 70,
          ),
        ],
      )),
    );
  }
}
