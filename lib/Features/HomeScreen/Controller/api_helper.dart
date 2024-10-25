import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../Models/ProductModel.dart';

class ProductService extends GetConnect implements GetxService {
  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List products = json.decode(response.body);
      for (var i in products) {
        i["qty"] = 1;
      }
      return products.map((product) {
        return ProductModel.fromJson(product);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
