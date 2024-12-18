import '../../../cart/data/models/cart_product_model.dart';

class ProductModel {
  final String imageUrl;
  final String desc;
  final int price;
  final String name;
  final Map<String, dynamic> storeInfo;
  final String type;
  ProductModel({
    required this.type,
    required this.storeInfo,
    required this.imageUrl,
    required this.desc,
    required this.price,
    required this.name,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      type: json['type'],
      storeInfo: json['storeInfo'],
      imageUrl: json['image'],
      desc: json['detalis'],
      price: json['price'],
      name: json['name'],
    );
  }

  factory ProductModel.fromCart(CartProductModel cartProductModel) {
    return ProductModel(
      type: cartProductModel.type,
      storeInfo: cartProductModel.storeInfo,
      imageUrl: cartProductModel.image,
      desc: cartProductModel.desc,
      price: cartProductModel.price,
      name: cartProductModel.name,
    );
  }

  factory ProductModel.fromPurchase(Map<String, dynamic> json) {
        return ProductModel(
      type: json['type'],
      storeInfo: json['storeInfo'],
      imageUrl: json['image'],
      desc: json['detalis'],
      price: json['picePrice'],
      name: json['name'],
    );
  }
}
