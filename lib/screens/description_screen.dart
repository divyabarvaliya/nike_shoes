import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/model/shoes_model.dart';

import '../core/constants/constants.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key, required this.shoes});
  final ShoesModel shoes;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  RxDouble shoesPos = (-Dimens.horizontalBlockSize * 80).obs;
  Future<void> changePosition() async {
    await Future.delayed(Duration(milliseconds: 200));
    shoesPos.value = 0;
  }

  @override
  void initState() {
    super.initState();
    changePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimens.verticalBlockSize * 15,
            left: 0,
            right: 0,
            child: Image.asset(
              ImagesAsset.max,
              height: Dimens.verticalBlockSize * 50,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(ImagesAsset.nikeBox, scale: 3.8),
          ),

          Obx(
            () => AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              top: Dimens.horizontalBlockSize * 60,
              right: shoesPos.value,
              child: Transform.rotate(
                angle: -0.8,
                child: Image.asset(
                  widget.shoes.img,
                  width: Dimens.verticalBlockSize * 50,
                  fit: BoxFit.contain,
                  height: Dimens.verticalBlockSize * 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(IconsAsset.back, scale: 3.5),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Men ',
                      style: AppTextStyle.bodyRegular[13]?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyScale[20],
                        fontFamily: FontFamily.poppins,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${widget.shoes.title}',
                          style: AppTextStyle.bodyRegular[20]?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(IconsAsset.bag, scale: 3.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
