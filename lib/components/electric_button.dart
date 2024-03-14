import 'package:flutter/material.dart';

class ElectricButton extends StatelessWidget {
  final VoidCallback buttonPressed;
  final String title;

  const ElectricButton({required this.buttonPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    //ElevatedButton is simply an ElevatedButton with a custom decoration
    return ElevatedButton(
        onPressed: buttonPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 129, 133, 240)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
            ),
            alignment: Alignment.center,
            //size is constant for all MaterialStateProperties
            minimumSize: MaterialStateProperty.all(Size(
                MediaQuery.of(context).size.width * 0.57,
                MediaQuery.of(context).size.height * 0.044)),
            maximumSize: MaterialStateProperty.all(Size(
                MediaQuery.of(context).size.width * 0.7,
                MediaQuery.of(context).size.height * 0.3))),
        child: Text(
          title,
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 25,
              letterSpacing: 2),
          textAlign: TextAlign.center,
        ));
  }
}
