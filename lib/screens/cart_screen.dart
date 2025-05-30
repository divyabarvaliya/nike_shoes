import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/controller/main_controller.dart';
import 'package:nike_shoes/core/model/shoes_model.dart';
import 'package:nike_shoes/core/utils/format.dart';
import 'package:nike_shoes/core/widgets/entry_list_item.dart';

import '../core/constants/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  RxDouble totalAmt = 0.0.obs;

  _countTotalAmt() {
    totalAmt.value = 0.0;
    for (int i = 0; i < MainController.to.cart.length; i++) {
      totalAmt.value += MainController.to.cart[i].price;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _countTotalAmt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [_appbar(), _cartItem(), _bottom()]),
    );
  }

  _bottom() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.s_20(),
        vertical: Dimens.verticalBlockSize * 2,
      ),
      height: Dimens.verticalBlockSize * 30,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryListItem(
            index: 0,
            child: Text(
              'Your Order',
              style: AppTextStyle.bodyRegular[25]?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dimens.verticalBlockSize * 0.5,
              bottom: Dimens.verticalBlockSize * 5,
            ),
            child: EntryListItem(
              index: 0,
              child: Text(
                'Nike Free Shipping is available*',
                style: AppTextStyle.bodyRegular[14]?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.poppins,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EntryListItem(
                index: 0,
                child: Text(
                  'Total:',
                  style: AppTextStyle.bodyRegular[24]?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              EntryListItem(
                index: 0,
                child: Obx(
                  () => Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: '\$',
                      style: AppTextStyle.bodyRegular[20]?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text:
                              StringFormat.priceFormat(
                                totalAmt.value,
                              ).split('\$')[1],
                          style: AppTextStyle.bodyRegular[30]?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          EntryListItem(
            index: 0,
            child: EntryListItem(
              index: 2,
              child: Bounceable(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.s_16(),
                    vertical: Dimens.verticalBlockSize * 2.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: AppTextStyle.bodyRegular[18]?.copyWith(
                      fontWeight: FontWeight.w600,
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

  _appbar() {
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
                  // Get.back();
                },
                child: Image.asset(IconsAsset.category, scale: 3.5),
              ),
              Text(
                'Bag',
                style: AppTextStyle.bodyRegular[20]?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Stack(
                children: [
                  Image.asset(IconsAsset.bag, scale: 3.5),
                  Transform.translate(
                    offset: Offset(13, -2),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          MainController.to.cart.length.toString(),
                          style: AppTextStyle.bodyRegular[10]?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartItem() {
    return Expanded(
      child: Obx(
        () => ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: MainController.to.cart.length,
          separatorBuilder: (c, sI) {
            return SizedBox(height: Dimens.verticalBlockSize * 2);
          },
          itemBuilder: (c, i) {
            ShoesModel cart = MainController.to.cart[i];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
              child: EntryListItem(
                index: i,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffEFEFEF)),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffE6EAF4).withAlpha(90), // Shadow color
                        spreadRadius: 2, // How wide the  shadow spreads
                        blurRadius: 3, // How soft the shadow is
                        offset: Offset(0, 3), // Shadow position (x, y)
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: Dimens.verticalBlockSize * 10,
                        width: Dimens.horizontalBlockSize * 30,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(cart.img, fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(width: Dimens.s_10()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.title,
                            style: AppTextStyle.bodyRegular[12]?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyScale[20],
                            ),
                          ),
                          SizedBox(height: Dimens.verticalBlockSize * 0.5),
                          Text(
                            StringFormat.priceFormat(cart.price * cart.piece),
                            style: AppTextStyle.bodyRegular[18]?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: Dimens.s_15()),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (cart.piece > 1) {
                                  cart.piece--;
                                  totalAmt.value -=
                                      MainController.to.cart[i].price;
                                }
                                MainController.to.cart.refresh();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: Dimens.verticalBlockSize * 2.5,
                              child: Center(
                                child: Text(
                                  '${cart.piece}',
                                  style: AppTextStyle.bodyRegular[12]?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                if (cart.piece < 5) {
                                  cart.piece++;

                                  MainController.to.cart.refresh();
                                  totalAmt.value +=
                                      MainController.to.cart[i].price;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
