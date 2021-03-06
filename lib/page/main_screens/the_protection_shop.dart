import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/models/products.dart';
import 'package:my_cities_time/page/main_screens/product_detail.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'favourites.dart';

class TheProtectionShop extends StatefulWidget {
  @override
  _TheProtectionShopState createState() => _TheProtectionShopState();
}

class _TheProtectionShopState extends State<TheProtectionShop> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: DrawerWidget(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bggg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 150,
                left: 40,
                right: 8,
              ),
              child: Row(
                children: [
                  Text(
                    "Sun Protection",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Favourites(),
                              ));
                        },
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 35,
                        )),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        state.all_products == null
                            ? 0
                            : state.all_products.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 15, bottom: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Card(
                            color: cardColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20, bottom: 20, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.all_products[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "OpenSans",
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Text(
                                            "\$${state.all_products[index].price}",
                                            style: TextStyle(
                                                color: fontOrange,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "OpenSans",
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        state.all_products[index].subtitle,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "OpenSans"),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        state.all_products[index].quantity,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "OpenSans"),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _onShare(context,
                                              state.all_products[index]);
                                        },
                                        // child: Icon(
                                        //   Icons.sync,
                                        //   color: fontOrange,
                                        //   size: 30,
                                        // )
                                        child: Image.asset(
                                          "assets/images/share.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (state.all_favourites.contains(
                                              state.all_products[index])) {
                                            kDatabase
                                                .child('favourites')
                                                .child(state.userModel.userId)
                                                .child(state
                                                    .all_favourites[index]
                                                    .productId)
                                                .remove();
                                            state.remotefavourite(index);
                                          } else {
                                            String uid = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                            state.all_products[index]
                                                .productId = uid;
                                            kDatabase
                                                .child('favourites')
                                                .child(state.userModel.userId)
                                                .child(uid)
                                                .set(state.all_products[index]
                                                    .toJson());

                                            state.addfavourite(
                                                state.all_products[index]);
                                          }
                                          // setState(() {
                                          //   loader = false;
                                          // });
                                        },

                                        child: state.all_favourites == null
                                            ? Icons.favorite_border
                                            : state.all_favourites.contains(
                                                    state.all_products[index])
                                                ? Image.asset(
                                                    "assets/images/heartFilled.png",
                                                    height: 30,
                                                    width: 30)
                                                : Image.asset(
                                                    "assets/images/heartEmpty.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Image.network(
                                    state.all_products[index].imageurl,
                                    width: 100.0,
                                    height: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  );
                })

                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
//This will share the product with users through email and whatsapp
  _onShare(BuildContext context, Product product) async {
    final RenderBox box = context.findRenderObject();
    List<String> imageurls = List<String>();
    imageurls.add(product.imageurl);

    await Share.share("Product Url:" + product.producturl,
        subject: product.quantity,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
