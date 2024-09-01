import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/core/configs/assets/images.dart';
import 'package:drdrakify/core/configs/assets/vectors.dart';
import 'package:drdrakify/core/configs/themes/Gradient_Button.dart';
import 'package:drdrakify/core/configs/themes/gradientLine.dart';
import 'package:drdrakify/core/usecase/auth/signup.dart';
import 'package:drdrakify/data/models/auth/create_user_request.dart';
import 'package:drdrakify/prsentation/authentication/pages/login_signup.dart';
import 'package:drdrakify/prsentation/authentication/pages/signIn.dart';
import 'package:drdrakify/prsentation/home/pages/Home.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signText(context),
      appBar: BasicAppbar(
        title: const Image(
          image: AssetImage('${AppImages.basepath}logo.png'),
          height: 45,
          width: 45,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginSignup(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(context),
            const SizedBox(
              height: 50,
            ),
            _fullNameWidget(context),
            const SizedBox(
              height: 20,
            ),
            _emailField(context),
            const SizedBox(
              height: 20,
            ),
            _passwordField(context),
            const SizedBox(
              height: 20,
            ),
            GradientButton(
                text: 'Create Account',
                onPressed: () async {
                  var result = await sl<SignupUseCase>().call(
                    params: CreateUserRequest(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        password: _password.text.toString()),
                  );
                  result.fold((l) {
                    var snackbar = SnackBar(content: Text(l));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, (r) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Home(),
                        ),
                        (route) => false);
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GradientLine(
                  gradient_color: const [
                    Color(0xFFFFD319),
                    Color(0xFFFF2975),
                    Color(0xFF8C1EFF),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                GradientLine(
                  gradient_color: const [
                    Color(0xFF8C1EFF),
                    Color(0xFFFF2975),
                    Color(0xFFFFD319),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SvgPicture.asset(
                    '${AppVectors.basepath}Google.svg',
                    height: 30,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  child: SvgPicture.asset(
                    context.isDarkMode
                        ? '${AppVectors.basepath}Apple_White.svg'
                        : '${AppVectors.basepath}Apple_Black.svg',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// ignore: unused_element
  Widget _registerText(BuildContext context) {
    return Text(
      'Register',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameWidget(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _signText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Signin(),
                ),
              );
            },
            child: const Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
