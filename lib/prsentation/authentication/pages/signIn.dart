import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/core/configs/assets/images.dart';
import 'package:drdrakify/core/configs/assets/vectors.dart';
import 'package:drdrakify/core/configs/themes/Gradient_Button.dart';
import 'package:drdrakify/core/configs/themes/gradientLine.dart';
import 'package:drdrakify/core/configs/themes/password_textField.dart';
import 'package:drdrakify/core/usecase/auth/signin.dart';
import 'package:drdrakify/data/models/auth/signin_user_request.dart';
import 'package:drdrakify/prsentation/authentication/pages/login_signup.dart';
import 'package:drdrakify/prsentation/authentication/pages/register.dart';
import 'package:drdrakify/prsentation/home/pages/Home.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signin extends StatelessWidget {
  Signin({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _registerText(context),
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
            _signInText(context),
            const SizedBox(
              height: 50,
            ),
            _username_emailField(context),
            const SizedBox(
              height: 20,
            ),
            _passwordField(context),
            const SizedBox(
              height: 20,
            ),
            GradientButton(
                text: 'Sign In',
                onPressed: () async {
                  var result = await sl<SignInUseCase>().call(
                    params: SigninUserRequest(
                        email: _email.text.toString(),
                        password: _password.text.toString()),
                  );
                  result.fold(
                    (l) {
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Home(),
                          ),
                          (route) => false);
                    },
                  );
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
  Widget _signInText(BuildContext context) {
    return Text(
      'Sign In',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  // ignore: non_constant_identifier_names
  Widget _username_emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Username Or Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      style: TextStyle(
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return PasswordField(controller: _password);
  }

  Widget _registerText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not a member ?',
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
                  builder: (BuildContext context) => Register(),
                ),
              );
            },
            child: const Text(
              'Register Now',
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
