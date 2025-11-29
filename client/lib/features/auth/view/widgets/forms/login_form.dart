import 'package:client/features/auth/view/widgets/buttons/custom_text_button.dart';
import 'package:client/features/auth/view/widgets/buttons/gradient_button.dart';
import 'package:client/features/auth/view/widgets/inputs/custom_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
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
    return Form(
      key: formKey,
      child: Column(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login.',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Column(
            spacing: 20,
            children: [
              Column(
                spacing: 16,
                children: [
                  Customfield(controller: emailController, hintText: 'Email'),
                  Customfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ],
              ),
              const GradientButton(text: 'Login'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const CustomTextButton(text: 'Sign up'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
