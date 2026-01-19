import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:course_scheduling/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:course_scheduling/features/auth/presentation/pages/signup_page.dart';
import 'package:course_scheduling/features/auth/presentation/widgets/auth_field.dart';
import 'package:course_scheduling/features/auth/presentation/widgets/auth_gradient_btn.dart';
import 'package:course_scheduling/features/courses/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (_) => false,
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In.',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                AuthField(
                  hintText: 'email',
                  controller: emailController,
                  obscureText: false,
                ),
                const SizedBox(height: 15),

                AuthField(
                  hintText: 'password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                AuthGradientBtn(
                  name: 'Sign In',
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        AuthSignIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, LoginPage.route());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppPallete.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
