part of 'student_courses_bloc.dart';

@immutable
sealed class StudentCoursesEvent {}


class LoadStudentCourses extends StudentCoursesEvent {
  final String userId;

  LoadStudentCourses({required this.userId});
}

