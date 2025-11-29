import 'package:client/features/auth/view/widgets/buttons/custom_text_button.dart';
import 'package:client/features/auth/view/widgets/buttons/gradient_button.dart';
import 'package:client/features/auth/view/widgets/inputs/custom_field.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
            'Sign Up.',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Column(
            spacing: 20,
            children: [
              Column(
                spacing: 16,
                children: [
                  Customfield(controller: nameController, hintText: 'Name'),
                  Customfield(controller: emailController, hintText: 'Email'),
                  Customfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ],
              ),
              const GradientButton(text: 'Sign up'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const CustomTextButton(text: 'Login'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
