import 'package:client/features/auth/view/widgets/buttons/custom_text_button.dart';
import 'package:client/features/auth/view/widgets/forms/signup_form.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  static MaterialPageRoute<SignupPage> route() =>
      MaterialPageRoute(builder: (context) => const SignupPage());

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    void handleLogin() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Column(
              spacing: 32,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up.',
                  style: Theme.of(context).textTheme.displayLarge,
                ),

                const SignupForm(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomTextButton(text: 'Login', onPressed: handleLogin),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
