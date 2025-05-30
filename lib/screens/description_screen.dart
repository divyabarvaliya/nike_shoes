import 'dart:math';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/controller/main_controller.dart';
import 'package:nike_shoes/core/model/shoes_model.dart';
import 'package:nike_shoes/core/utils/debouncer.dart';
import 'package:nike_shoes/core/utils/format.dart';
import 'package:nike_shoes/core/utils/snackbar.dart';
import 'package:nike_shoes/core/widgets/entry_list_item.dart';
import 'package:nike_shoes/screens/cart_screen.dart';

import '../core/constants/constants.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key, required this.shoes});
  final ShoesModel shoes;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final deBouncer = DeBouncer(milliSecond: 300);
  RxDouble shoesPos = (-Dimens.horizontalBlockSize * 80).obs;
  RxDouble shoesT = (Dimens.verticalBlockSize * 27).obs;
  RxDouble shoesH = (Dimens.verticalBlockSize * 30).obs;
  RxDouble shoesW = (Dimens.verticalBlockSize * 50).obs;
  RxDouble opacity = 1.0.obs;
  RxDouble shoesO = 1.0.obs;

  Color color = Colors.white;
  Future<void> changePosition() async {
    await Future.delayed(Duration(milliseconds: 200));
    shoesPos.value = -Dimens.horizontalBlockSize * 5;
  }

  @override
  void initState() {
    super.initState();
    changePosition();
    color = getRandomColor();
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // fully opaque
      random.nextInt(256), // red: 0–255
      random.nextInt(256), // green: 0–255
      random.nextInt(256), // blue: 0–255
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _maxView(),
          _nikeBox(),
          _colors(),
          _priceView(),
          _shoesView(),
          _addToBag(),
          _sizeView(),
          _appBar(),
        ],
      ),
    );
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
      child: SafeArea(
        child: EntryListItem(
          index: 0,
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
    );
  }

  _sizeView() {
    return Positioned(
      left: Dimens.s_20(),
      top: Dimens.verticalBlockSize * 15,
      child: Column(
        children: [
          Text(
            'Size',
            style: AppTextStyle.bodyRegular[14]?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimens.verticalBlockSize * 1.5),
          Column(
            children:
                MainController.to.sizes.map((size) {
                  int idx = MainController.to.sizes.indexOf(size);
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: Dimens.verticalBlockSize * 2,
                    ),
                    child: Obx(
                      () => EntryListItem(
                        index: idx,
                        child: GestureDetector(
                          onTap: () {
                            MainController.to.selSize.value = idx;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Dimens.s_40(),
                            width: Dimens.s_40(),
                            decoration: BoxDecoration(
                              color:
                                  MainController.to.selSize.value == idx
                                      ? AppColors.blue
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xffEFEFEF)),
                            ),
                            child: Text(
                              '$size',
                              style: AppTextStyle.bodyRegular[14]?.copyWith(
                                fontWeight: FontWeight.w500,
                                color:
                                    MainController.to.selSize.value == idx
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  _shoesView() {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 700),
        top: shoesT.value,
        right: shoesPos.value,
        left: 0,
        child: Transform.rotate(
          angle: -0.7,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: shoesO.value,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: shoesH.value,
              width: shoesW.value,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.shoes.img),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addToBag() {
    return Obx(
      () => Positioned(
        bottom: Dimens.verticalBlockSize * 16,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 700),
          opacity: opacity.value,
          child: Transform.rotate(
            angle: 1.57,
            child: Align(
              alignment: Alignment.center,
              child: ActionSlider.standard(
                width: Dimens.horizontalBlockSize * 23,
                height: Dimens.verticalBlockSize * 5,
                backgroundColor: Colors.black,
                customBackgroundBuilder: (c, a, w) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Transform.rotate(
                        angle: -1.57,
                        child: Image.asset(
                          IconsAsset.down,
                          color: Colors.white,
                          scale: 4,
                        ),
                      ),
                    ),
                  );
                },
                customForegroundBuilder: (c, a, w) {
                  return Container(
                    width: 60,
                    height: Dimens.verticalBlockSize * 7,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.rotate(
                      angle: -1.57,
                      child: Image.asset(
                        IconsAsset.bag,
                        color: Colors.white,
                        scale: 4,
                      ),
                    ),
                  );
                },
                action: (controller) async {
                  controller.loading();
                  shoesT.value = Dimens.verticalBlockSize * 120;
                  shoesH.value = Dimens.verticalBlockSize * 7;
                  shoesW.value = Dimens.verticalBlockSize * 27;
                  shoesPos.value = 0;
                  opacity.value = 0;
                  await Future.delayed(const Duration(milliseconds: 200));
                  shoesO.value = 0;
                  deBouncer.run(() {
                    bool isExist = MainController.to.cart.any((item) {
                      if (item.img == widget.shoes.img) {
                        return true;
                      }
                      return false;
                    });
                    if (!isExist) {
                      MainController.to.cart.add(widget.shoes);
                      SnackBarUtil.showToasts(
                        message: '${widget.shoes.title} successfully Added',
                      );
                    } else {
                      SnackBarUtil.showToasts(
                        message: '${widget.shoes.title} already in cart',
                      );
                    }
                    Get.off(() => CartScreen());
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _priceView() {
    return Positioned(
      left: Dimens.s_20(),
      top: Dimens.verticalBlockSize * 65,
      child: EntryListItem(
        index: 0,
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: '\$',
            style: AppTextStyle.bodyRegular[20]?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text:
                    StringFormat.priceFormat(widget.shoes.price).split('\$')[1],
                style: AppTextStyle.bodyRegular[30]?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '\n10% OFF',
                style: AppTextStyle.bodyRegular[12]?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xffBE3032),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _colors() {
    return Positioned(
      right: Dimens.s_20(),
      top: Dimens.verticalBlockSize * 50,
      child: Column(
        children: [
          Text(
            'Colour',
            style: AppTextStyle.bodyRegular[14]?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Dimens.verticalBlockSize * 1.5),
          Column(
            children: List.generate(2, (i) {
              return Obx(
                () => EntryListItem(
                  index: i,
                  child: GestureDetector(
                    onTap: () {
                      MainController.to.selColor.value = i;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: Dimens.verticalBlockSize * 2,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: Dimens.s_35(),
                        width: Dimens.s_35(),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == 1 ? color : Colors.white,
                          border:
                              MainController.to.selColor.value == i
                                  ? Border.all(color: AppColors.blue, width: 5)
                                  : null,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  _maxView() {
    return Positioned(
      top: Dimens.verticalBlockSize * 15,
      left: 0,
      right: 0,
      child: Image.asset(
        ImagesAsset.max,
        height: Dimens.verticalBlockSize * 50,
      ),
    );
  }

  _nikeBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset(ImagesAsset.nikeBox, scale: 3.8),
    );
  }
}
