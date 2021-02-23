class Users{
   String userId;
   String username;
   String email;
   String password;
   String confirm_password;
   String imageurl;


  Users({this.userId,this.username,this.email,this.password,this.confirm_password});
  Users.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId=map["userId"];
    username=map["username"];
    email=map["email"];
    imageurl=map["imageurl"]==null?null:map["imageurl"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }
  toJson(){
return {
  'userId':userId,
  'username':username,
  'email':email,
  'password':password,
  'confirm_password':password,
  "image_url":imageurl==null?"":imageurl

};

  }

}