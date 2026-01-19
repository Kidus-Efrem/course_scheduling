import 'package:course_scheduling/core/theme/app_pallet.dart';
import 'package:course_scheduling/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:course_scheduling/features/auth/presentation/pages/login_page.dart';
import 'package:course_scheduling/features/auth/presentation/widgets/auth_field.dart';
import 'package:course_scheduling/features/auth/presentation/widgets/auth_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(
                hintText: 'name',
                controller: nameController,
                obscureText: false,
              ),
              const SizedBox(height: 15),
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
                name: 'Sign Up',
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                      AuthSignUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: nameController.text.trim(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignupPage.route());
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign In',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
