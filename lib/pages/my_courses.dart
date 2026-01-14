import 'dart:ffi';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                      ),
                    ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Courses'),
                    Text("You are enrolled in 5 Courses", )
                  ],
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