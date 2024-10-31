import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final mailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mailController.dispose();
    nameController.dispose();
    passController.dispose();
    super.dispose();
    //formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 60,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Sign up to\n',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Pallete.whiteColor),
                        children: [
                          TextSpan(
                            text: 'start listening',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Pallete.whiteColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'name@domain.com',
                      labelText: 'Email',
                      controller: mailController,
                    ),
                    CustomTextField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passController,
                      isObscure: true,
                    ),
                    Button(
                      text: "Sign Up.",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                            await AuthRemoteRepository().signup(mail: mailController.text, name: nameController.text, password: passController.text);
                          }
                      },
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Pallete.subtitleText),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          child: const Text('Log in here',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
