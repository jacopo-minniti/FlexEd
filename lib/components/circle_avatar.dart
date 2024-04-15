import 'dart:math';
import 'package:flutter/material.dart';

import '../pages/unit_page.dart';

class CircleAvatarIndicator extends StatelessWidget {
  final dynamic unit;
  const CircleAvatarIndicator(this.unit);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UnitPage(unit: unit)),
          );
        },
        child: Container(
          margin: EdgeInsets.only(right: Random().nextDouble() * 150),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 115,
                        height: 115,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(143, 148, 251, 1)),
                          strokeWidth: 13,
                          value: 1,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 85,
                        child: CircleAvatar(
                          backgroundColor: unit['isCompleted']
                              ? const Color.fromRGBO(143, 148, 251, 1)
                              : const Color.fromRGBO(143, 148, 251, 0.3),
                          radius: 56,
                          child: Image.asset(
                            'assets/star.png',
                            height: 58,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(unit['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
