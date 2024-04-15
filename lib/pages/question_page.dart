import 'package:flex_education/pages/coding_page.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  final unit;
  QuestionPage(this.unit);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _currentIndex = 0; // Track current question index
  bool wrongAnswer = false;
  bool rightAnswer = false;

  int? _selectedAnswer; // Store user selected answer index

  void checkAnswer(int? selectedIndex, int indexCorrect) {
    if (selectedIndex == null) {
      return;
    }
    if (selectedIndex == indexCorrect) {
      if (_currentIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CodingPage(widget.unit)),
        );
        return;
      }
      setState(() {
        wrongAnswer = false;
        rightAnswer = true;
        _currentIndex++;
        _selectedAnswer = null;
      });
    } else {
      setState(() {
        wrongAnswer = true;
        rightAnswer = false;
        _selectedAnswer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = widget.unit['exam']['questions'][_currentIndex]['question'];
    var options = [
      widget.unit['exam']['questions'][_currentIndex]['option0'],
      widget.unit['exam']['questions'][_currentIndex]['option1'],
      widget.unit['exam']['questions'][_currentIndex]['option2'],
      widget.unit['exam']['questions'][_currentIndex]['option3']
    ];
    var indexCorrect =
        widget.unit['exam']['questions'][_currentIndex]['indexCorrect'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text('Challenge Question ${_currentIndex + 1}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(question),
            SizedBox(height: 16.0),
            for (int i = 0; i < options.length; i++)
              RadioListTile<int>(
                title: Text(options[i]),
                value: i,
                fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) => Color.fromRGBO(143, 148, 251, 1),
                ),
                groupValue: _selectedAnswer,
                onChanged: (value) => setState(() => _selectedAnswer = value),
              ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) => Color.fromRGBO(143, 148, 251, 1),
                ),
              ),
              onPressed: () {
                return checkAnswer(_selectedAnswer, indexCorrect);
              },
              child: Text('Submit Answer'),
            ),
// Conditionally display "Next Question" button after answer check
            SizedBox(
              height: 20,
            ),
            if (wrongAnswer)
              const Text(
                'Wrong Answer! Try Again',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            if (rightAnswer)
              const Text(
                'Congrats!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
