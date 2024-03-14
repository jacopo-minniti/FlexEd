import 'package:flutter/material.dart';

class CircleAvatarIndicator extends StatelessWidget {
  final Color _backgroundColor;
  final String _img;
  final String txt;
  final double distance_right;

  const CircleAvatarIndicator(
      this._backgroundColor, this._img, this.txt, this.distance_right);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: distance_right),
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
                      backgroundColor: _backgroundColor,
                      radius: 56,
                      child: Image.asset(
                        _img,
                        height: 58,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(txt,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
