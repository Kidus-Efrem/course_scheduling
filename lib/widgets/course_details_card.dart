import 'package:flutter/material.dart';

class CourseDetailsCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String description;
  const CourseDetailsCard({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 6),
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title,),
          Text(description)
        ],
      ),
    );
  }
}
