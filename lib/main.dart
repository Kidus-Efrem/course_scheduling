import 'package:course_scheduling/pages/home_page.dart';
import 'package:course_scheduling/pages/my_courses.dart';
import 'package:course_scheduling/widgets/calander.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',

      home:  MyCourses(),
    );
  }
}