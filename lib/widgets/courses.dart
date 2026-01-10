import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  String courseName;
  String lecturer;
  String room;
  String courseNumber;
  String numberOfStudent;
  Courses({
    super.key,
    required this.lecturer,
    required this.courseName,
    required this.numberOfStudent,
    required this.room,
    required this.courseNumber
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow:[BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 6),
              color: Colors.black.withOpacity(0.15)
            )]
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.library_books), Text(courseNumber),Text(courseName), Text(lecturer), Text(room), Text(numberOfStudent),
            Expanded(child: SizedBox(height: 2 ,child: LinearProgressIndicator(value: 0.7)))]),
        ),

    );
  }
}
