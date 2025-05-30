import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/widgets/ellipse.dart';
import 'package:nike_shoes/screens/home_screen.dart';

import '../core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Dimens().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, -90),
            child: Image.asset(ImagesAsset.justDoIt, scale: 3.8),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(ImagesAsset.justDoIt, scale: 3.8),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Dimens.verticalBlockSize * 3,
            child: Image.asset(IconsAsset.logo, scale: 4),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.s_20()),
              child: Text(
                'Unleash Your Potential, Elevate Your Game.',
                textAlign: TextAlign.start,
                style: AppTextStyle.bodyRegular[30]?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimens.verticalBlockSize * 52,
            left: Dimens.horizontalBlockSize * 36,
            child: CustomPaint(
              size: const Size(130, 45), // Adjust as needed
              painter: EllipsePainter(),
            ),
          ),
          Positioned(
            bottom: Dimens.verticalBlockSize * 4,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.s_20()),
              child: Bounceable(
                onTap: () {
                  Get.to(() => HomeScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Dimens.verticalBlockSize * 7,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Text(
                    'Start Now',
                    style: AppTextStyle.bodyRegular[18]?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.poppins,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
