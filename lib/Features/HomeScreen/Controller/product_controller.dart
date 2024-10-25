import 'package:get/get.dart';

import '../../../Models/ProductModel.dart';
import 'api_helper.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var productList = await ProductService().fetchProducts();
      products.addAll(productList);
    } finally {
      isLoading(false);
    }
  }
}
