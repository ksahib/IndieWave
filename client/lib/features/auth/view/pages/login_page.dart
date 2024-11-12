import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:client/features/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool keepLoggedIn = false;

    @override
  void initState() {
    super.initState();
    //_checkAutoLogin();
  }

  // Method to check if the user can be automatically logged in
  // Future<void> _checkAutoLogin() async {
  //   final result = await AuthRemoteRepository().autologin(); 


  //   if (result) {
  //     // If login is successful, navigate to the main page
  //     //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  //   }
  // }


  @override
  void dispose() {
    mailController.dispose();
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
        next ?. when(
          data: (data)  {
          showSnackBar(context, 'Logged In.', Pallete.greenColor);
          //uncomment after implementation of homepage
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context) => Homepage()
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
                        text: 'Sign in to\n',
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
                      hintText: 'Password',
                      controller: passController,
                      isObscure: true,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: keepLoggedIn, 
                          onChanged: (bool ? value) {
                            setState(() {
                              keepLoggedIn = value ?? false;
                            });
                          }
                        ),
                        const Text(
                          'Keep me logged in.',
                           style: TextStyle(color: Pallete.whiteColor),
                        ),
                      ],
                    ),
                    Button(
                      text: "Sign In.",
                      onPressed: () async{
                        if(formKey.currentState!.validate())  {
                          await ref.read(authViewmodelProvider.notifier).loginUser(
                              email: mailController.text, 
                              password: passController.text,
                              keepLoggedIn: keepLoggedIn,
                              );
                        }
                      },
                    ),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Pallete.subtitleText),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: const Text('Sign up',
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
