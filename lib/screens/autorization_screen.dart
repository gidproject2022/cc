// import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stick/constains/colors.dart';
import 'package:stick/main.dart';

class AutorizationScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const AutorizationScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  State<AutorizationScreen> createState() => _AutorizationScreenState();
}

class _AutorizationScreenState extends State<AutorizationScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/backgrounds/autorization.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: primaryWhiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              height: MediaQuery.of(context).size.height * 0.673,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/logo.png',
                    width: 84,
                    height: 84,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Creation Community",
                    style: TextStyle(
                      fontFamily: 'Harlow',
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Авторизация",
                    style: TextStyle(
                      fontFamily: 'Century Gothic Bold',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.795 - 20,
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5.0)),
                              fillColor: primaryInputColor,
                              filled: true,
                              hintText: "Электронная почта",
                              hintStyle: const TextStyle(
                                color: primaryInputTextColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // validator: (email) =>
                            //     email != null && !EmailValidator.validate(email)
                            //         ? 'Введите корректную почту!'
                            //         : null,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.795 - 20,
                          child: TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5.0)),
                              fillColor: primaryInputColor,
                              filled: true,
                              hintText: "Пароль",
                              hintStyle: const TextStyle(
                                color: primaryInputTextColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            obscureText: true,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // validator: (value) =>
                            //     value != null && value.length < 6
                            //         ? "Длина пароля не меньше 6 символов"
                            //         : null,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.795 - 20,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryOrangeColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            onPressed: signIn,
                            child: const Text(
                              "Войти",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: primaryBlackColor,
                              fontSize: 14,
                            ),
                            text: "Нет аккаунта?",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignUp,
                                text: " Создать аккаунт.",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: primaryOrangeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Пароль или электронная почта неверны'),
        duration: Duration(seconds: 2),
      ));
    }

    // Navigator.of(context) not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
