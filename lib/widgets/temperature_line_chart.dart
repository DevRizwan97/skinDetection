import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/models/weather.dart';

import 'package:charts_flutter/src/text_element.dart' as TextElement;
import 'package:charts_flutter/src/text_style.dart' as style;
import '../main.dart';

/// Renders a line chart from forecast data
/// x axis - date
/// y axis - temperature
class TemperatureLineChart extends StatelessWidget {

  final List<Weather> weathers;
  final bool animate;

  TemperatureLineChart(this.weathers, {this.animate});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(40.0),
        child: charts.TimeSeriesChart([
          new charts.Series<Weather, DateTime>(
            id: 'Temperature',


            colorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault,
            domainFn: (Weather weather, _) =>
                DateTime.fromMillisecondsSinceEpoch(
                    weather.uv_date * 1000),
            measureFn: (Weather weather, _) =>
                weather.uv_value,
            data: weathers,


          ),

        ],
          behaviors: [
            LinePointHighlighter(
              drawFollowLinesAcrossChart: true,
              showHorizontalFollowLine: LinePointHighlighterFollowLineType.all,
            ),
          ],
          domainAxis: new charts.DateTimeAxisSpec(
          tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
            day: new charts.TimeFormatterSpec(
                format: 'EEE', transitionFormat: 'EEE', noonFormat: 'EEE'),
          ),
          showAxisLine: false,
        ),

            defaultRenderer: new charts.LineRendererConfig(includePoints: true),
            animate: animate,
            animationDuration: Duration(milliseconds: 500),



        )
    );
  }
}
class CustomCircleSymbolRenderer extends CircleSymbolRenderer {

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, FillPatternType fillPattern, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor,fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
        fill: Color.black
    );
    var textStyle =style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(

        TextElement.TextElement("1", style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round()
    );
  }
}