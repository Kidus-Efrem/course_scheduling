import 'package:course_scheduling/widgets/courses.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.book_outlined),
                Container(
                  child: Column(
                    children: [
                      Text('My Courses'),
                      Text("You are enrolled in 5 Courses", )
                    ],
                  ),
                )


              ],
            ),

            Expanded(
              child: Courses(
                lecturer: 'Dr kebede',
                room: 'Room 2001',
                courseName: 'Physics',
                courseNumber: 'cs231',
                numberOfStudent: '234',
              ),
            )
          ],
        ),
      ),
    );
  }
}