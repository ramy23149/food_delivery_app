import 'dart:io';

class UploadedProductModel {
  final String name;
  final int price;
  final File image;
  final String desc;
  final String subCategory;
  final String districte;
  final String? brand;

  UploadedProductModel({

    this.brand,
    required this.subCategory,
    required this.desc,
    required this.name,
    required this.price,
    required this.image,
    required this.districte,
  });
}
