class Product {
  String userId;
 String name;
 String subtitle;
 String quantity;
 String imageurl;
  String producturl;
  String price;

  Product(
      {this.userId, this.name,this.subtitle,this.imageurl,this.producturl,this.quantity});

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
//    userId=map["userId"];
   name=map["name"];
   subtitle=map["subtitle"];
   quantity=map["quantity"]==null?null:map["quantity"];
   imageurl=map["imageurl"]==null?null:map["imageurl"];
    producturl=map["producturl"]==null?null:map["producturl"];
    price=map["price"]==null?"":map["price"].toString();

    // date=map["date"];
    // time=map["time"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }

}