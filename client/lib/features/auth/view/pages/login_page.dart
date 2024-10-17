import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final Formkey = GlobalKey<FormState>();

  @override
  void dispose()  {
    mailController.dispose();
    passController.dispose();
    super.dispose();
    Formkey.currentState!.validate();
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
                key: Formkey,
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
                              text: 'Sign in to\n',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Pallete.whiteColor),
                              children: [
                                TextSpan(
                                  text: 'start listening',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Pallete.whiteColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'name@domain.com',
                      labelText: 'Email',
                      controller: mailController,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passController,
                      isObscure: true,
                    ),
                    Button(
                      text: "Sign In.",
                      onPressed: () {
                        
                      },
                      ),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Pallete.subtitleText),
                        ),
                        TextButton(
                      onPressed: () {},
                      child: const Text('Sign up', style: TextStyle(decoration: TextDecoration.underline, color: Colors.white)),
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