class Skin{
   String userId;
   String reapply;
   String recommended_timing;
   String spf;
   String sun_radiation;
   String uv_level;
   String skintype;



  Skin({this.userId,this.reapply,this.recommended_timing,this.spf,this.sun_radiation,this.uv_level,this.skintype});
  Skin.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId=map["userId"];
    reapply=map["reapply"];
    recommended_timing=map["recommended_timing"];
    spf=map["spf"];
    sun_radiation=map["sun_radiation"];
    uv_level=map["uv_level"];
    skintype=map["skintype"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }
  toJson(){
return {
  'userId':userId,
  'reapply':reapply,
  'recommended_timing':recommended_timing,
  'spf':spf,
  'sun_radiation':sun_radiation,
  'uv_level':uv_level,
  'skintype':skintype

};

  }

}