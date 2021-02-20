class Skin {
  String userId;
  String reapply;
  String recommended_timing;
  String spf;
  String sun_radiation;
  String uv_level;
  String skintype;
  String city;
  String cancer_risk;
  String skincolor;
  String temperature;
  String weathericon;
  String weather_detail;
  String date;
  String time;
  String month;
double lat;
double long;

  Skin(
      {this.userId, this.reapply, this.recommended_timing, this.spf, this.sun_radiation, this.month,this.uv_level, this.skintype,this.city,this.cancer_risk,this.skincolor,this.date,this.time,this.lat,this.long});

  Skin.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    //userId=map["userId"];
    reapply = map["Reapply"];
    recommended_timing = map["Recommended"];
    spf = map["SPF"];
    sun_radiation = map["Sun radiation"];
    uv_level = map["UV level"];
    skintype = map["skintype"];
    city=map["city"];
    skincolor=map["skincolor"];
    cancer_risk=map["cancer_risk"];
    temperature=map["temperature"];
    weathericon=map["weathericon"];
    weather_detail=map["weather_detail"];
    // date=map["date"];
    // time=map["time"];
    // password=map["password"];
    // confirm_password=map["confirm_password"];


  }

  Skin.fromJson1(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    //userId=map["userId"];
    reapply = map["reapply"];
    recommended_timing = map["recommended_timing"];
    spf = map["spf"];
    sun_radiation = map["sun_radiation"];
    uv_level = map["uv_level"];
    skintype = map["skintype"];
    city=map["city"];
    skincolor=map["skincolor"];
    cancer_risk=map["cancer_risk"];
    temperature=map["temperature"];
    weathericon=map["weathericon"];
    weather_detail=map["weather_detail"];
    date=map["date"];
    time=map["time"];
    lat=double.parse(map["lat"].toString());

    long=double.parse(map["long"].toString());
    month=map["month"]==null?"":map["month"];
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
      'skintype':skintype,
      "city":city,
      "skincolor":skincolor,
      "cancer_risk":cancer_risk,
      "weathericon":weathericon,
      "weather_detail":weather_detail,
      "temperature":temperature,
      "date":date,
      "time":time,
      "lat":lat,
      "long":long,
      "month":month

    };

  }
}
