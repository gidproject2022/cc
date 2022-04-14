import 'package:flutter/material.dart';
import 'package:stick/screens/autorization_screen.dart';
import 'package:stick/screens/registration_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? AutorizationScreen(onClickedSignUp: toggle)
      : RegistrationScreen(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
