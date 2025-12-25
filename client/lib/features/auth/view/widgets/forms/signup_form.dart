import 'package:client/core/utils/utils.dart';
import 'package:client/core/widgets/inputs/custom_field.dart';
import 'package:client/features/auth/view/widgets/buttons/gradient_button.dart';
import 'package:client/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
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

  void handleSignup() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .signUpUser(
          name: nameController.text.trim(),
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
        data: (data) {
          showSnackBar(context, 'Account created successfully, plese login!');

          Navigator.pop(context);
        },
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
              Customfield(controller: nameController, hintText: 'Name'),
              Customfield(controller: emailController, hintText: 'Email'),
              Customfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
            ],
          ),
          GradientButton(
            text: 'Sign up',
            onPressed: handleSignup,
            loading: isLoading,
          ),
        ],
      ),
    );
  }
}
