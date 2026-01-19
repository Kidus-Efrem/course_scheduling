
import 'package:course_scheduling/widgets/course.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
  toolbarHeight: 110,
  elevation: 4,
  backgroundColor: Colors.transparent,

  centerTitle: false,

  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade200,
          Colors.blue.shade700,
        ],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 8,
        ),
      ],
    ),
  ),

  title: Row(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.menu_book_outlined,
          color: Colors.white,
          size: 22,
        ),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "My Courses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "You are enrolled in 5 Courses",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  ),
),




  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Course(
          lecturer: 'Dr kebede',
          room: 'Room 2001',
          courseName: 'Physics',
          courseNumber: 'cs231',
          numberOfStudent: '234',
          color: Colors.blue,
        ),
      ],
    ),
  ),

);

  }
}