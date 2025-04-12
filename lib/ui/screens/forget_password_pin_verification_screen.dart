import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_fully_functional/ui/screens/login_screen.dart';
import 'package:task_manager_fully_functional/ui/screens/reset_password_screen.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';

class ForgetPasswordPinVerificationScreen extends StatefulWidget {
  const ForgetPasswordPinVerificationScreen({super.key});

  @override
  State<ForgetPasswordPinVerificationScreen> createState() =>
      _ForgetPasswordPinVerificationScreenState();
}

final TextEditingController _pinCodeTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ForgetPasswordPinVerificationScreenState
    extends State<ForgetPasswordPinVerificationScreen> {
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
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit verification has been sent to your email.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _pinCodeTEController,
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Text('Verify'),
                  ),
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen(),),);
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (pre) => false);
  }
  @override
  void dispose() {
    _pinCodeTEController.clear();
    super.dispose();
  }


}