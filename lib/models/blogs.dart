class Blog {
  String userId;
 String title;
 String sub_description;
 String description;
 List<String> imageurls;

  Blog(
      {this.userId, this.title,this.description,this.sub_description,this.imageurls});

  Blog.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
//    userId=map["userId"];
   title=map["title"];
   description=map["description"];
   sub_description=map["sub_description"]==null?null:map["sub_description"];
   imageurls=map["imageurls"]==null?null:map["imageurls"];
    // date=map["date"];
    // time=map["time"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }

}
