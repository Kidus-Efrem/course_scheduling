import 'package:course_scheduling/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:course_scheduling/features/courses/data/repositories/courses_repository_impl.dart';
import 'package:course_scheduling/features/courses/domain/usecases/get_student_courses.dart';
import 'package:course_scheduling/features/courses/presentation/bloc/student_courses_bloc.dart';
import 'package:course_scheduling/features/courses/presentation/pages/student_my_courses.dart';
import 'package:course_scheduling/features/courses/presentation/pages/settings.dart';
import 'package:course_scheduling/features/courses/presentation/pages/student_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentMainScreen extends StatefulWidget {
  final String userId;
  final SupabaseClient supabaseClient;
  const StudentMainScreen({
    super.key,
    required this.userId,
    required this.supabaseClient,
  });

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int _selectedIndex = 0;


  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index; // Switch the tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentCoursesBloc(
        getStudentCourses: GetStudentCourses(
          CoursesRepositoryImpl(
            remoteDataSource: CourseRemoteDataSourceImpl(widget.supabaseClient),
          ),
        ),
      )..add(LoadStudentCourses(userId: widget.userId)),
      child: Builder(

        builder: (context) {

          final pages = [
            StudentHomePage(),
            BlocBuilder<StudentCoursesBloc, StudentCoursesState>(
              builder: (context, state) {
                if (state is StudentCoursesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is StudentCoursesLoaded) {
                  return StudentMyCourses(courses: state.courses);
                }
                if (state is StudentCoursesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
            Settings(),
          ];

          return Scaffold(
            body: IndexedStack(index: _selectedIndex, children: pages),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onTabTapped,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyCoursesPage {}
