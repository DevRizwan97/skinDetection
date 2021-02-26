class Blog {
  String userId;
 String title;
 String sub_description;
 String description;
 String imageurl;

  Blog(
      {this.userId, this.title,this.description,this.sub_description,this.imageurl});

  Blog.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
//    userId=map["userId"];
   title=map["title"];
   description=map["description"];
   sub_description=map["sub_description"]==null?null:map["sub_description"];
   imageurl=map["image_url"]==null?null:map["image_url"];
    // date=map["date"];
    // time=map["time"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }

}
