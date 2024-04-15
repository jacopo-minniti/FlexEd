import 'package:flex_education/components/electric_button.dart';
import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodingPage extends StatefulWidget {
  final unit;

  const CodingPage(this.unit);

  @override
  State<CodingPage> createState() => _CodingPageState();
}

class _CodingPageState extends State<CodingPage> {
  final isCodeShown = false;
  var currentIndex = 0;
  var isWrong = false;
  var isRight = false;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text('Challenge Question ${currentIndex + 1}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(widget.unit['exam']['coding'][currentIndex]['question']),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter your code',
                labelStyle: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(
                          143, 148, 251, 1)), // Set border color to purple
                  borderRadius:
                      BorderRadius.circular(10.0), // Set border radius
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElectricButton(
              color: Color.fromRGBO(143, 148, 251, 1),
              buttonPressed: () {
                if (controller.text !=
                    widget.unit['exam']['coding'][currentIndex]['answer']) {
                  setState(
                    () {
                      isWrong = true;
                      isRight = false;
                      print(widget.unit['exam']['coding'][currentIndex]
                          ['answer']);
                    },
                  );
                } else {
                  if (currentIndex == 2) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Congratulations!'),
                          content: Text('You passed the exam'),
                          shadowColor: Color.fromRGBO(143, 148, 251, 1),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Provider.of<MyProvider>(context, listen: false)
                                    .completeUnit('unit1');
                                Navigator.pop(context);
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/'));
                              },
                              child: Text(
                                'Return to Units',
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    //Navigator.pop(context);
                    return;
                  }
                  setState(
                    () {
                      isRight = true;
                      isWrong = false;
                      currentIndex++;
                    },
                  );
                }
              },
              title: 'Check Code',
            ),
            SizedBox(
              height: 30,
            ),
            if (isWrong)
              const Text(
                'Wrong Answer! Try Again',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            if (isRight)
              const Text(
                'Great! You are almost there',
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
