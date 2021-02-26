import 'package:flutter/material.dart';
import 'package:my_cities_time/models/weather.dart';

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



        // if(weather!=null)
        //   Text(
        //     "Sunburn Time: ",
        //     style:
        //     TextStyle(color: AppStateContainer.of(context).theme.accentColor),
        //   ),

      ],

    );
  }
}
