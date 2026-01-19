import 'package:bloc/bloc.dart';
import 'package:course_scheduling/features/courses/domain/entities/courses.dart';
import 'package:meta/meta.dart';

part 'student_courses_event.dart';
part 'student_courses_state.dart';

class StudentCoursesBloc extends Bloc<StudentCoursesEvent, StudentCoursesState> {
  StudentCoursesBloc() : super(StudentCoursesInitial()) {
    on<StudentCoursesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
