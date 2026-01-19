part of 'student_courses_bloc.dart';

@immutable
sealed class StudentCoursesState {}

final class StudentCoursesInitial extends StudentCoursesState {}




class StudentCoursesLoading extends StudentCoursesState {}

class StudentCoursesLoaded extends StudentCoursesState {
  final Courses courses;

  StudentCoursesLoaded(this.courses);
}

class StudentCoursesError extends StudentCoursesState {
  final String message;

  StudentCoursesError(this.message);
}
