import 'package:client/features/auth/view/widgets/buttons/custom_text_button.dart';
import 'package:client/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemoLoginButton extends ConsumerStatefulWidget {
  const DemoLoginButton({super.key});

  @override
  ConsumerState<DemoLoginButton> createState() => _DemoLoginButtonState();
}

class _DemoLoginButtonState extends ConsumerState<DemoLoginButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void handleDemoLogin() async {
      setState(() {
        loading = true;
      });

      await ref
          .read(authViewModelProvider.notifier)
          .loginUser(email: 'test@test.com', password: 'testtest');

      setState(() {
        loading = false;
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Want to try it out? Use a ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        CustomTextButton(
          text: 'demo account',
          onPressed: loading ? null : handleDemoLogin,
        ),
      ],
    );
  }
}
