import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/ui/screens/login_screen.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

final TextEditingController _newPasswordTEController = TextEditingController();
final TextEditingController _confirmNewPasswordTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Set a new password with minimum length of 6 letters.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                 TextFormField(
                   controller: _newPasswordTEController,
                   textInputAction: TextInputAction.next,
                   decoration: InputDecoration(
                     hintText: 'new password',
                   ),
                 ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm new password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Text('Confirm')),
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (pre) => false);
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
    _newPasswordTEController.clear();
    _confirmNewPasswordTEController.clear();
    super.dispose();
  }

}
