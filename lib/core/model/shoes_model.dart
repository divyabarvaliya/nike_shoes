class ShoesModel {
  String img;
  String title;
  double price;
  bool isStar;
  bool isSave;
  int piece;

  ShoesModel({
    required this.img,
    required this.title,
    required this.price,
    this.piece = 1,
    this.isStar = false,
    this.isSave = false,
  });

  ShoesModel copyWith({
    String? img,
    String? title,
    double? price,
    int? piece,
    bool? isStar,
    bool? isSave,
  }) {
    return ShoesModel(
      img: img ?? this.img,
      title: title ?? this.title,
      price: price ?? this.price,
      piece: piece ?? this.piece,
      isStar: isStar ?? this.isStar,
      isSave: isSave ?? this.isSave,
    );
  }
}
