import 'package:course_scheduling/features/courses/presentation/pages/home_page.dart';
import 'package:course_scheduling/features/courses/presentation/pages/my_courses.dart';
import 'package:course_scheduling/features/courses/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),        // Tab 0
    MyCourses(),   // Tab 1
    Settings(),    // Tab 2
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index; // Switch the tab
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
        selectedItemColor: Colors.blue,
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

class MyCoursesPage {
}
