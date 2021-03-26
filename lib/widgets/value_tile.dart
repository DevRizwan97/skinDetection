import 'package:flutter/material.dart';
import 'package:my_cities_time/models/weather.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'empty_widget.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;
final Weather weather;
  ValueTile(this.label, this.value, {this.iconData,this.weather});
  getsunscreentime(context,String uvi_index){
    var state = Provider.of<AuthState>(context, listen: false);
    List<Map> all_data=state.all_excel_data;
    print(state.all_excel_data);
    for(int i=0;i<state.all_excel_data.length;i++){
      String uv=all_data[i]['uv'].toString();
      String uv_index=(int.parse(double.parse(uvi_index).floor().toString()).toString());

      if(uv==uv_index&&all_data[i]['skintype'].toString()==state.all_skin_data[state.all_skin_data.length-1].skintype){
        String time= state.all_excel_data[i]['time'].toString();
        try {
          return (int.parse(double.parse(time).floor().toString()).toString())+" min";
          // break;
        }catch(e){

          return 'safe';
        }
      }

    }}
  @override
  Widget build(BuildContext context) {

    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(
              color: AppStateContainer.of(context)
                  .theme
                  .accentColor
                  .withAlpha(80)),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
                iconData,
                color: AppStateContainer.of(context).theme.accentColor,
                size: 20,
              )
            : EmptyWidget(),
        SizedBox(
          height: 5,
        ),
        Text(
          this.value,
          style:
              TextStyle(color: AppStateContainer.of(context).theme.accentColor),
        ),


        if(weather!=null)
          Text(
            "UV: "+(weather.uv_value!=null?weather.uv_value.toString():""),
            style:
            TextStyle(color: AppStateContainer.of(context).theme.accentColor),
          ),



        if(weather!=null)
          Text(
            'Sunburn : ${getsunscreentime(context, weather.uv_value!=null?weather.uv_value.toString():'0')}',
            style:
            TextStyle(color: AppStateContainer.of(context).theme.accentColor),
          ),

      ],

    );
  }
}
