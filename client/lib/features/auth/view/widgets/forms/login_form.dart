import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/inputs/custom_field.dart';
import 'package:client/features/auth/view/widgets/buttons/gradient_button.dart';
import 'package:client/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void handleLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val.isLoading == true),
    );

    ref.listen(authViewModelProvider, (_, next) {
      next.when(
        data: (_) {},
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Form(
      key: formKey,
      child: Column(
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
          GradientButton(
            text: 'Login',
            onPressed: handleLogin,
            loading: isLoading,
          ),
        ],
      ),
    );
  }
}
