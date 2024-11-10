import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
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
    final isLoading = ref.watch(authViewmodelProvider.select((val) => val?.isLoading == true));
    ref.listen(
      authViewmodelProvider,
      (_, next) {
        next ?. when(data: (data)  {
          showSnackBar(context, 'Account created succesfully.', Pallete.greenColor);
          //uncomment after implementation of homepage
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context) => HomePage()
            ),
            (_) => false,
          );
        }, 
        error: (error, st) {
          showSnackBar(context, error.toString(), Pallete.errorColor);
        }, 
        loading: () {}
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: isLoading ? const Loader() 
      : Center(
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
                            await ref.read(authViewmodelProvider.notifier).signUpUser(
                              email: mailController.text, 
                              name: nameController.text, 
                              password: passController.text,
                              );
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
