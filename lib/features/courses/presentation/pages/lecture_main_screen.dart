import 'package:course_scheduling/features/courses/presentation/pages/student_home_page.dart';
import 'package:course_scheduling/features/courses/presentation/pages/student_my_courses.dart';
import 'package:flutter/material.dart';
import 'package:course_scheduling/features/courses/presentation/pages/settings.dart';

/// Lecturer Main Screen
class LecturerMainScreen extends StatefulWidget {
  const LecturerMainScreen({super.key});

  @override
  State<LecturerMainScreen> createState() => _LecturerMainScreenState();
}

class _LecturerMainScreenState extends State<LecturerMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StudentHomePage(),       // Tab 0
    const StudentHomePage(),      // Tab 1
    const Settings(),       // Tab 2
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
