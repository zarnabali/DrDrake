import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/core/configs/assets/images.dart';
import 'package:drdrakify/core/configs/assets/vectors.dart';
import 'package:drdrakify/core/configs/themes/Gradient_Button.dart';
import 'package:drdrakify/core/configs/themes/logo.dart';
import 'package:drdrakify/prsentation/authentication/pages/register.dart';
import 'package:drdrakify/prsentation/authentication/pages/signIn.dart';
import 'package:drdrakify/prsentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppbar(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ChooseMode(),
                ),
              );
            },
            title: null,
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern,
            ),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage('${AppImages.basepath}wkXag.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo(),
                const SizedBox(
                  height: 55,
                ),
                Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Text(
                  'DrDrake is a proprietary US audio streaming and media services provider ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GradientButton(
                        text: 'Register',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Register(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Signin(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
