import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/buttons/custom_text_button.dart';
import 'package:client/features/auth/view/widgets/buttons/demo_login_button.dart';
import 'package:client/features/auth/view/widgets/forms/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static MaterialPageRoute<LoginPage> route() =>
      MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void handleSignup() {
      Navigator.push(context, SignupPage.route());
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 512),
            child: Column(
              spacing: 32,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login.', style: Theme.of(context).textTheme.displayLarge),

                const LoginForm(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomTextButton(text: 'Sign up', onPressed: handleSignup),
                  ],
                ),

                const DemoLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
