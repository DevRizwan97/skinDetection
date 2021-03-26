import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/products.dart';
import 'package:my_cities_time/page/main_screens/shop_detail_page.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
              padding: const EdgeInsets.only(top: 150, left: 40, right: 8),
              child: Text(
                "Favourites",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        state.all_favourites == null
                            ? 0
                            : state.all_favourites.length, (index) {
                  return GestureDetector(
                    onTap: () {

  //                Navigate to shopDetail Page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopDetailPage(),
                          ));


                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 15, bottom: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
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
                                            state.all_favourites[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "OpenSans",
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Text(
                                            "\$${state.all_favourites[index].price}",
                                            style: TextStyle(
                                                color: fontOrange,
                                                fontFamily: "OpenSans",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        state.all_favourites[index].subtitle,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "OpenSans"),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        state.all_favourites[index].quantity,
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
                                          //Will share this product
                                          _onShare(context,
                                              state.all_favourites[index]);
                                        },
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
                                          //Condition will check whether this product exist in userdatabase
                                         //If the product exist then it will remove the product from database

                                          if (state.all_favourites.contains(
                                              state.all_favourites[index])) {
                                            kDatabase
                                                .child('favourites')
                                                .child(state.userModel.userId)
                                                .child(state
                                                    .all_favourites[index]
                                                    .productId)
                                                .remove();
                                            state.remotefavourite(index);
                                          }
                                          //Else it will add the product in database
                                          else {
                                            kDatabase
                                                .child('favourites')
                                                .child(state.userModel.userId)
                                                .child(DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString())
                                                .set(state.all_favourites[index]
                                                    .toJson());

                                            state.addfavourite(
                                                state.all_favourites[index]);
                                          }
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
                                    state.all_favourites[index].imageurl,
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  );
                })),
              ),
            )
          ],
        ),
      ),
    );
  }
//This will share this product
  _onShare(BuildContext context, Product product) async {
    final RenderBox box = context.findRenderObject();
    List<String> imageurls = List<String>();
    imageurls.add(product.imageurl);

    await Share.share(
        "Name:" +
            product.name +
            "\n" " Product Name:" +
            product.subtitle +
            "\n" "Price: " '\$' +
            product.price +
            "\n" "Quantity: " +
            product.quantity,
        subject: product.quantity,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
