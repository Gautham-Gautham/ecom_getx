import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/ProductModel.dart';
import '../Controller/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final CartController cartController = Get.find<CartController>();
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
                      'Cart',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff2A977D),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () {
                  if (cartController.cartItems.isEmpty) {
                    return Center(
                        child: Text(
                      "No Items in Cart",
                      style: GoogleFonts.poppins(),
                    ));
                  } else {
                    return Expanded(
                        flex: 0,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.5, crossAxisCount: 2),
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            cartController.catQty.add(1);
                            ProductModel product =
                                cartController.cartItems[index];
                            int count = product.qty ?? 1;
                            // final quantity =
                            //     cartController.itemCounts[product?.id] ?? 1;
                            return Container(
                              height: 250,
                              width: 170,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            const Icon(
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
                                              width: 3,
                                            ),
                                            Obx(
                                              () => Text(
                                                '\$${(cartController.catQty[index] * product.price)}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Color(0xff2A977D)),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                cartController.catQty[index]++;
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "+",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Obx(
                                              () => Text(
                                                "${cartController.catQty[index]}",
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (cartController
                                                        .catQty[index] >
                                                    1) {
                                                  cartController
                                                      .catQty[index]--;
                                                } else {
                                                  cartController
                                                      .removeFromCart(index);
                                                }
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                  child: RotatedBox(
                                                    quarterTurns: 3,
                                                    child: Text(
                                                      "|",
                                                      style:
                                                          GoogleFonts.poppins(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // Expanded(
                                  //     flex: 0,
                                  //     child: GridView.builder(
                                  //       shrinkWrap: true,
                                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  //           childAspectRatio: 0.5, crossAxisCount: 2),
                                  //       itemCount: 2,
                                  //       itemBuilder: (context, index) => Container(
                                  //         height: 250,
                                  //         width: 170,
                                  //         color: Colors.white,
                                  //         child: Column(
                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             const Image(
                                  //               height: 118,
                                  //               image: AssetImage('assets/images/shirt1.png'),
                                  //             ),
                                  //             const SizedBox(
                                  //               height: 5,
                                  //             ),
                                  //             Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Column(
                                  //                 mainAxisAlignment: MainAxisAlignment.start,
                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     'Shirt',
                                  //                     style: GoogleFonts.poppins(
                                  //                         color: Colors.grey,
                                  //                         fontWeight: FontWeight.bold),
                                  //                   ),
                                  //                   const SizedBox(
                                  //                     height: 5,
                                  //                   ),
                                  //                   Text(
                                  //                     "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  //                     style: GoogleFonts.poppins(
                                  //                         fontWeight: FontWeight.bold,
                                  //                         fontSize: 15),
                                  //                   ),
                                  //                   const SizedBox(
                                  //                     height: 10,
                                  //                   ),
                                  //                   Row(
                                  //                     children: [
                                  //                       Icon(
                                  //                         Icons.star,
                                  //                         color: Colors.orange,
                                  //                       ),
                                  //                       Text(
                                  //                         '4.9 | 2336',
                                  //                         style: GoogleFonts.poppins(
                                  //                           color: Colors.grey,
                                  //                           fontWeight: FontWeight.bold,
                                  //                         ),
                                  //                       ),
                                  //                       SizedBox(
                                  //                         width: 3,
                                  //                       ),
                                  //                       Text(
                                  //                         '\$12.00',
                                  //                         style: GoogleFonts.poppins(
                                  //                             fontWeight: FontWeight.bold,
                                  //                             fontSize: 20,
                                  //                             color: Color(0xff2A977D)),
                                  //                       )
                                  //                     ],
                                  //                   ),
                                  //                   const SizedBox(
                                  //                     height: 10,
                                  //                   ),
                                  //                   Row(
                                  //                     mainAxisAlignment: MainAxisAlignment.center,
                                  //                     children: [
                                  //                       Container(
                                  //                         height: 25,
                                  //                         width: 35,
                                  //                         decoration: BoxDecoration(
                                  //                           border: Border.all(color: Colors.black),
                                  //                           borderRadius: BorderRadius.circular(6),
                                  //                         ),
                                  //                         child: Center(
                                  //                           child: Text(
                                  //                             "+",
                                  //                             style: GoogleFonts.poppins(),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                       const SizedBox(
                                  //                         width: 10,
                                  //                       ),
                                  //                       Text(
                                  //                         "1",
                                  //                         style: GoogleFonts.poppins(),
                                  //                       ),
                                  //                       const SizedBox(
                                  //                         width: 10,
                                  //                       ),
                                  //                       Container(
                                  //                         height: 25,
                                  //                         width: 35,
                                  //                         decoration: BoxDecoration(
                                  //                           border: Border.all(color: Colors.black),
                                  //                           borderRadius: BorderRadius.circular(6),
                                  //                         ),
                                  //                         child: Center(
                                  //                           child: RotatedBox(
                                  //                             quarterTurns: 3,
                                  //                             child: Text(
                                  //                               "|",
                                  //                               style: GoogleFonts.poppins(),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   )
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ))
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
