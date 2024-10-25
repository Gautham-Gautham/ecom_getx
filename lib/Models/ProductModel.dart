// // To parse this JSON data, do
// //
// //     final productModel = productModelFromMap(jsonString);
//
// import 'dart:convert';
//
// List<ProductModel> productModelFromMap(String str) => List<ProductModel>.from(
//     json.decode(str).map((x) => ProductModel.fromMap(x)));
//
// String productModelToMap(List<ProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
//
// class ProductModel {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String category;
//   final String image;
//   final Rating rating;
//
//   ProductModel({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.category,
//     required this.image,
//     required this.rating,
//   });
//
//   ProductModel copyWith({
//     int? id,
//     String? title,
//     double? price,
//     String? description,
//     String? category,
//     String? image,
//     Rating? rating,
//   }) =>
//       ProductModel(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         price: price ?? this.price,
//         description: description ?? this.description,
//         category: category ?? this.category,
//         image: image ?? this.image,
//         rating: rating ?? this.rating,
//       );
//
//   factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
//         id: json["id"],
//         title: json["title"],
//         price: json["price"]?.toDouble(),
//         description: json["description"],
//         category: json["category"],
//         image: json["image"],
//         rating: Rating.fromMap(json["rating"]),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "price": price,
//         "description": description,
//         "category": category,
//         "image": image,
//         "rating": rating.toMap(),
//       };
// }
//
// class Rating {
//   final double rate;
//   final int count;
//
//   Rating({
//     required this.rate,
//     required this.count,
//   });
//
//   Rating copyWith({
//     double? rate,
//     int? count,
//   }) =>
//       Rating(
//         rate: rate ?? this.rate,
//         count: count ?? this.count,
//       );
//
//   factory Rating.fromMap(Map<String, dynamic> json) => Rating(
//         rate: json["rate"]?.toDouble(),
//         count: json["count"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "rate": rate,
//         "count": count,
//       };
// }
import 'package:hive/hive.dart';

part 'ProductModel.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final Rating rating;
  @HiveField(7)
  int? qty = 1;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        qty: json["qty"] ?? 1,
        rating: Rating.fromMap(json["rating"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "qty": qty,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toMap(),
      };
  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
    int? qty,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        qty: qty ?? this.qty,
      );
}

@HiveType(typeId: 1)
class Rating {
  @HiveField(0)
  final double rate;

  @HiveField(1)
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) =>
      Rating(
        rate: rate ?? this.rate,
        count: count ?? this.count,
      );

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "count": count,
      };
}
