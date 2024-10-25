import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../Models/ProductModel.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  var catQty = <int>[].obs;
  late Box<ProductModel> cartBox;

  @override
  void onInit() {
    super.onInit();
    cartBox = Hive.box<ProductModel>('cartBox');

    cartItems.addAll(cartBox.values.toList());
  }

  void addToCart(ProductModel product, int index) {
    if (cartItems.contains(product)) {
      catQty[index]++;
    } else {
      cartItems.add(product);
      cartBox.add(product);
    }
  }

  void removeFromCart(int index) {
    cartBox.deleteAt(index);
    cartItems.removeAt(index);
  }

  void clearCart() {
    cartItems.clear();
    cartBox.clear();
  }
}
