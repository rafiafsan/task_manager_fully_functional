import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/ui/screens/forget_password_email_verify_screen.dart';
import 'package:task_manager_fully_functional/ui/screens/register_screen.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController _emailTEController = TextEditingController();
final TextEditingController _passwordTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                'Get Started With',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                controller: _emailTEController,
                decoration: const InputDecoration(
                  hintText: 'email',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordTEController,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: _onTapForgetPasswordButton,
                        child: Text("Forget Password?")),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            children: [
                          TextSpan(text: "Don't have account ?"),
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton,
                          ),
                        ])),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _onTapForgetPasswordButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPasswordPinVerificationScreen()));

  }
  void _onTapSignUpButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }


  // void dispose() {
  //   _emailTEController.dispose();
  //   _passwordTEController.dispose();
  //   super.dispose();
  // }
}
