import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/controller/main_controller.dart';
import 'package:nike_shoes/core/model/category_model.dart';
import 'package:nike_shoes/core/model/shoes_model.dart';
import 'package:nike_shoes/core/utils/format.dart';
import 'package:nike_shoes/core/widgets/entry_list_item.dart';
import 'package:nike_shoes/screens/description_screen.dart';

import '../core/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxDouble shoesPos = (-Dimens.horizontalBlockSize * 32).obs;

  late ScrollController _scrollViewController;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    changePosition();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {});
        }
      }
    });
  }

  Future<void> changePosition() async {
    await Future.delayed(Duration(milliseconds: 200));
    shoesPos.value = Dimens.horizontalBlockSize * 32;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 700),
                height:
                    isScrollingDown
                        ? Dimens.verticalBlockSize * 35
                        : Dimens.verticalBlockSize * 40,
              ),
              Expanded(
                child: GridView.builder(
                  controller: _scrollViewController,
                  shrinkWrap: true,
                  itemCount: MainController.to.shoes.length,
                  padding: EdgeInsets.only(
                    left: Dimens.s_20(),
                    right: Dimens.s_20(),
                    top: Dimens.verticalBlockSize * 12,
                    bottom: Dimens.verticalBlockSize * 12,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: Dimens.s_20(), // Space between columns
                    mainAxisSpacing: 18, // Space between rows
                    childAspectRatio: 1 / 1.3, // Width to height ratio
                  ),
                  itemBuilder: (context, i) {
                    ShoesModel shoes = MainController.to.shoes[i];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DescriptionScreen(shoes: shoes));
                      },
                      child: Hero(
                        tag: shoes.img,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimens.verticalBlockSize * 2,
                            horizontal: Dimens.s_18(),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEFEFEF)),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: EntryListItem(
                            index: i,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(IconsAsset.star, scale: 3.5),
                                    SizedBox(width: Dimens.s_4()),
                                    Text(
                                      '4.8',
                                      style: AppTextStyle.bodyRegular[12]
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.greyScale[20],
                                          ),
                                    ),
                                    Spacer(),
                                    Image.asset(IconsAsset.save, scale: 3.5),
                                  ],
                                ),
                                Image.asset(
                                  shoes.img,
                                  height: Dimens.verticalBlockSize * 10,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shoes.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: AppTextStyle.bodyRegular[12]
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.greyScale[20],
                                          ),
                                    ),
                                    Text(
                                      StringFormat.priceFormat(shoes.price),
                                      style: AppTextStyle.bodyRegular[18]
                                          ?.copyWith(
                                            height: 1.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(IconsAsset.category, scale: 3.5),
                        Image.asset(IconsAsset.logo, scale: 7),
                        Image.asset(IconsAsset.bag, scale: 3.5),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
                  child: Text(
                    'New Collection',
                    style: AppTextStyle.bodyRegular[20]?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
                  child: Text(
                    'Explore the new collection of sneakers',
                    style: AppTextStyle.bodyRegular[12]?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.poppins,
                      color: AppColors.greyScale[20],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimens.verticalBlockSize * 3,
                    left: Dimens.s_25(),
                    right: Dimens.s_25(),
                  ),
                  child: Image.asset(ImagesAsset.offerCard),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  height: isScrollingDown ? 0 : Dimens.verticalBlockSize * 12,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Dimens.s_25(),
                      right: Dimens.s_25(),
                      top: Dimens.verticalBlockSize * 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        MainController.to.category.length,
                        (i) {
                          CategoryModel cat = MainController.to.category[i];
                          return GestureDetector(
                            onTap: () {
                              MainController.to.selCate.value = i;
                            },
                            child: EntryListItem(
                              index: i,
                              child: Obx(
                                () => SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cat.name,
                                        style: AppTextStyle.bodyRegular[20]
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  MainController
                                                              .to
                                                              .selCate
                                                              .value ==
                                                          i
                                                      ? Colors.black
                                                      : AppColors.greyScale[20],
                                            ),
                                      ),
                                      Text(
                                        '${cat.items} items',
                                        style: AppTextStyle.bodyRegular[12]
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: FontFamily.poppins,
                                              color:
                                                  MainController
                                                              .to
                                                              .selCate
                                                              .value ==
                                                          i
                                                      ? Colors.black
                                                      : AppColors.greyScale[20],
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              left: shoesPos.value,
              top: Dimens.horizontalBlockSize * 46,
              child: Transform.rotate(
                angle: -0.4,
                child: Image.asset(
                  ImagesAsset.offerShoes,
                  height: Dimens.verticalBlockSize * 25.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
