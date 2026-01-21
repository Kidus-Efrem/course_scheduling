import 'package:course_scheduling/core/secrets/app_secrets.dart';
import 'package:course_scheduling/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:course_scheduling/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:course_scheduling/features/auth/domain/usecases/get_profile.dart';
import 'package:course_scheduling/features/auth/domain/usecases/user_sign_in.dart';
import 'package:course_scheduling/features/auth/domain/usecases/user_sign_up.dart';
import 'package:course_scheduling/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:course_scheduling/features/auth/presentation/pages/login_page.dart';
import 'package:course_scheduling/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:course_scheduling/features/courses/data/repositories/courses_repository_impl.dart';
import 'package:course_scheduling/features/courses/domain/usecases/get_student_courses.dart';
import 'package:course_scheduling/features/courses/presentation/bloc/student_courses_bloc.dart';
import 'package:course_scheduling/features/courses/presentation/pages/student_home_content.dart';
import 'package:course_scheduling/features/courses/presentation/pages/student_main_screen.dart';
// import 'package:course_scheduling/features/courses/presentation/pages/my_courses.dart';
import 'package:course_scheduling/widgets/calander.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  final supabaseClient = Supabase.instance.client;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(supabaseClient),
              ),
            ),
            userSignIn: UserSignIn(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(supabaseClient),
              ),
            ),
            getProfile: GetProfile(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(supabaseClient),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => StudentCoursesBloc(
            getStudentCourses: GetStudentCourses(
              CoursesRepositoryImpl(
                remoteDataSource: CourseRemoteDataSourceImpl(supabaseClient),
              ),
            ),
          ),
        ),
      ],
      child: MyApp(supabaseClient: supabaseClient,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabaseClient;
  const MyApp({super.key, required this.supabaseClient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',

      home: LoginPage(supabaseClient: supabaseClient),
    );
  }
}
