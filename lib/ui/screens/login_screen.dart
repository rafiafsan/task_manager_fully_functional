import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/data/models/login_model.dart';
import 'package:task_manager_fully_functional/ui/controllers/auth_controller.dart';
import 'package:task_manager_fully_functional/ui/screens/forget_password_email_verify_screen.dart';
import 'package:task_manager_fully_functional/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_fully_functional/ui/screens/register_screen.dart';
import 'package:task_manager_fully_functional/ui/widgets/centered_circular_progress_ndicator.dart';
import 'package:task_manager_fully_functional/ui/widgets/screen_background.dart';

import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController _emailTEController = TextEditingController();
final TextEditingController _passwordTEController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _loginInProgress = false;

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
                validator: (String? value) {
                  String email = value?.trim() ?? '';
                  if (EmailValidator.validate(email) == false) {
                    return 'Enter a valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
                validator: (String? value) {
                  if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                    return 'Enter your password more then 6 letters.';
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: _loginInProgress == false,
                replacement: CenteredCircularProgressNdicator(),
                child: ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
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
                        ]
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
      ),
    );
  }

  void _onTapSignInButton() {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MainBottomNavScreen(),
    //   ),
    //     (predicate)=> false,
    // );
    if(_formKey.currentState!.validate()){
      _login();
    }
  }

  void _onTapForgetPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgetPasswordEmailVerificationScreen(),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }
  Future<void> _login() async {
    _loginInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    _loginInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      // TODO : save token to local
      AuthController.SaveUserInformation(loginModel.token, loginModel.userModel);
      // TODO : database setup
      // TODO : Logged in or not


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainBottomNavScreen(),
        ),
      );
    } else {
      showSnackBar(context,response.errorMessage,true);
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
