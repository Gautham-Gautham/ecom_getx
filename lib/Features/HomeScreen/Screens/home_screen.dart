import 'package:ecom_getx/Features/Cart/Screen/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Cart/Controller/cart_controller.dart';
import '../Controller/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: screenWidth *
                          0.6, // Adjust width based on screen size
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 40,
                            color: Colors.grey,
                          ),
                          hintText: 'Search..',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          Get.to(CartScreen());
                        },
                        child: Badge(
                          label:
                              Text(cartController.cartItems.length.toString()),
                          child: Image(
                            height: 30,
                            width: 30,
                            image: AssetImage(
                              'assets/icons/img.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Badge(
                      label: Text('9+'),
                      child: Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                          'assets/icons/chat.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 180,
                  width: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/images/main.png',
                    )),
                  )),
              Container(
                height: 130,
                width: screenWidth, // Dynamic width
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCategoryItem(
                        context, Icons.grid_view_outlined, 'Category'),
                    buildCategoryItem(
                        context, Icons.branding_watermark, 'Brand'),
                    buildCategoryItem(
                        context, Icons.shopping_basket_outlined, 'Shop'),
                    buildCategoryItem(
                        context, Icons.upcoming_outlined, 'TopUp'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Sale Product',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'See more',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2A977D),
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                        flex: 0,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.5, crossAxisCount: 2),
                          itemCount: productController.products.length,
                          itemBuilder: (context, index) {
                            final product = productController.products[index];
                            print(product.qty);
                            return Container(
                              height: 100,
                              width: 170,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        height: 118,
                                        width: 100,
                                        image: NetworkImage(product.image),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.category,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              product.title,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                ),
                                                Text(
                                                  '4.9 | 2336',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '\$${product.price}',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color(0xff2A977D)),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          cartController.addToCart(
                                              product, index);
                                        },
                                        icon: const Icon(CupertinoIcons.cart)),
                                  )
                                ],
                              ),
                            );
                          },
                        ));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget buildCategoryItem(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 53,
            width: 53,
            decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 32),
          ),
          const SizedBox(height: 14),
          Text(label, style: GoogleFonts.poppins(fontSize: 17)),
        ],
      ),
    );
  }
}
