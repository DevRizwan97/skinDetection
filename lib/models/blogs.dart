class Blog {
  String userId;
 String title;
 String sub_description;
 String description;
 String imageurl;
String link;
  Blog(
      {this.userId, this.title,this.description,this.sub_description,this.imageurl,this.link});

  Blog.fromJson(Map<dynamic, dynamic> map) {
    print(map);
    if (map == null) {
      return;
    }
//    userId=map["userId"];
   title=map["title"]["rendered"];
   sub_description=map["excerpt"]["rendered"]==null?null:map["excerpt"]["rendered"];
   link=map["link"];
   imageurl="http://xammin.pk/Suntastic/wp-json/wp/v2/media/"+map["featured_media"].toString();
//   imageurl=map["image_url"]==null?null:map["image_url"];
    // date=map["date"];
    // time=map["time"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }

}
