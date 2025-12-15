import 'package:client/features/auth/view/widgets/forms/signup_form.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  static MaterialPageRoute<SignupPage> route() =>
      MaterialPageRoute(builder: (context) => const SignupPage());

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SignupForm(),
      ),
    );
  }
}
