import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';
import 'forget_password_pin_verification_screen.dart';
import 'package:task_manager_fully_functional/ui/screens/forget_password_email_verify_screen.dart';

class ForgetPasswordEmailVerificationScreen extends StatefulWidget {
  const ForgetPasswordEmailVerificationScreen({super.key});

  @override
  State<ForgetPasswordEmailVerificationScreen> createState() =>
      _ForgetPasswordEmailVerificationScreenState();
}

final TextEditingController _emailTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ForgetPasswordEmailVerificationScreenState
    extends State<ForgetPasswordEmailVerificationScreen> {
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
                'Your Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'A 6 digit verification code will be sent to your email.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
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
                height: 16,
              ),
              ElevatedButton(
                  onPressed: _onTapSubmitButton,
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
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            children: [
                          TextSpan(text: "Already Have an account ?"),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
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
  void _onTapSubmitButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordPinVerificationScreen(),),);
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }


}
