import 'package:flutter/material.dart';

class CourseTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Take the whole width
      height: 130, // Set the fixed height for the container
      color: Colors.grey[300], // Placeholder color for demonstration
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image widget
          Image.asset(
            'assets/introduction_python.jpg', // Example image URL
            fit: BoxFit.cover, // Ensure the image covers the whole container
          ),
          // Text widget on top
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black, // Semi-transparent black background
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Introduction to Python',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
