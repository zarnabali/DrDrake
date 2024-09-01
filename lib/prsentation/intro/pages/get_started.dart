import 'package:drdrakify/core/configs/assets/images.dart';
import 'package:drdrakify/core/configs/themes/Gradient_Button.dart';
import 'package:drdrakify/core/configs/themes/colors.dart';
import 'package:drdrakify/core/configs/themes/logo.dart';
import 'package:drdrakify/prsentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AppImages.introBG),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          color: Colors.black.withOpacity(0.15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: logo(),
              ),
              const Spacer(),
              const Text(
                'Enjoy Listening To Music',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 21,
              ),
              const Text(
                'Discover, stream, and share your favorite music with DrDrake – your ultimate destination for an unparalleled musical journey',
                style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 21,
              ),
              GradientButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChooseMode(),
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
