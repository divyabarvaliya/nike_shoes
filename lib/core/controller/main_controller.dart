import 'package:get/get.dart';
import 'package:nike_shoes/core/model/category_model.dart';
import 'package:nike_shoes/core/model/shoes_model.dart';

import '../constants/constants.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  RxList<num> sizes = [9, 9.5, 10, 11].obs;
  RxList<ShoesModel> cart = <ShoesModel>[].obs;

  List<ShoesModel> shoes = <ShoesModel>[
    ShoesModel(title: 'Air Max 97', img: ImagesAsset.s_1, price: 20.99),
    ShoesModel(title: 'React Presto', img: ImagesAsset.s_2, price: 25.99),
    ShoesModel(title: 'Nike Air Force 1', img: ImagesAsset.s_3, price: 25.99),
    ShoesModel(
      title: 'Nike ZoomX Vaporfly',
      img: ImagesAsset.s_4,
      price: 25.99,
    ),
    ShoesModel(title: 'Nike Blazer Mid', img: ImagesAsset.s_5, price: 110),
    ShoesModel(title: 'Nike Jordan 1', img: ImagesAsset.s_6, price: 120),
    ShoesModel(title: 'Nike Metcon', img: ImagesAsset.s_7, price: 99),
    ShoesModel(title: 'Nike Pegasus 40', img: ImagesAsset.s_8, price: 99),
  ];
  List<CategoryModel> category = [
    CategoryModel(name: 'Lifestyle', items: 32),
    CategoryModel(name: 'Running', items: 24),
    CategoryModel(name: 'Tennis', items: 13),
  ];
  RxInt selCate = 0.obs;
  RxInt selSize = 0.obs;
  RxInt selColor = 0.obs;
}
