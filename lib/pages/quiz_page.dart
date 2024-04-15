import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  var score = 0.0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'Have you ever programmed before?',
      'answers': ['Yes', 'No'],
      'scores': [3, -10]
    },
    {
      'question': 'How many years of experience in Python do you have?',
      'answers': ['0', '1', '2', '3+'],
      'scores': [0, 3, 6, 10]
    },
    {
      'question': 'Are you familiar with Object Oriented Programming?',
      'answers': ['No', 'Yes, but not confident', 'Yes'],
      'scores': [0, 3, 6]
    },
    {
      'question':
          "Let's test your knowledge: Which of the following data types is mutable in Python?",
      'answers': ['String', 'Integer', 'Tuple', 'List'],
      'scores': [0, 0, 0, 3]
    },
  ];
  final List<Map<String, dynamic>> categories = [
    {'category': 'begginer', 'minScore': -30, 'maxScore': 5.0},
    {'category': 'intermediate', 'minScore': 5.1, 'maxScore': 13.0},
    {'category': 'expert', 'minScore': 13.1, 'maxScore': 30.0}
  ];
  var category = '';

  Future<void> _answerQuestion(index) async {
    score += (_questions[_questionIndex]['scores'] as List)[index];
    setState(() {
      _questionIndex++;
    });
    if (_questionIndex == 4) {
      for (int i = 0; i < 3; i++) {
        if (score >= categories[i]['minScore'] &&
            score <= categories[i]['maxScore']) {
          category = categories[i]['category'];
        }
      }
      await Provider.of<MyProvider>(context, listen: false).setLevel(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adjust Course Level'),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
      ),
      body: _questionIndex < _questions.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _questions[_questionIndex]['question'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ...(_questions[_questionIndex]['answers'] as List<String>)
                    .map((answer) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(143, 148, 251, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        int answerIndex = (_questions[_questionIndex]['answers']
                                as List<String>)
                            .indexOf(answer);
                        await _answerQuestion(answerIndex);
                      },
                      child: Text(answer),
                    ),
                  );
                }).toList(),
              ],
            )
          : Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(143, 148, 251, 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Level is Set!\nYou are ready to start learning\nLevel: ${category}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
