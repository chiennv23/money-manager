// /// Donut chart example. This is a simple pie chart with a hole in the middle.
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
//
// class DonutPieChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;
//
//   DonutPieChart(this.seriesList, {this.animate});
//
//   @override
//   Widget build(BuildContext context) {
//     return charts.PieChart(seriesList,
//         animate: animate,
//         // Configure the width of the pie slices to 60px. The remaining space in
//         // the chart will be left as a hole in the center.
//         defaultRenderer: charts.ArcRendererConfig(arcWidth: 30));
//   }
// }
//
// /// Sample linear data type.
// class LinearMoney {
//   final String title;
//   final charts.Color chartColor;
//   final Color titleColor;
//   final int id;
//   final int value;
//
//   LinearMoney(
//       this.title, this.chartColor, this.titleColor, this.id, this.value);
// }
