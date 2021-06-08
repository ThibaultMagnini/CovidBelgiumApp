import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as textel;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as style;

class Chart extends StatelessWidget {
  final List<Series> seriesList;
  Chart(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return new LineChart(
      seriesList,
      behaviors: [
        LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer()),
        SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag)
      ],
      selectionModels: [
        SelectionModelConfig(changedListener: (SelectionModel model) {
          CustomCircleSymbolRenderer.value = model.selectedSeries[0]
                  .domainFn(model.selectedDatum[0].index)
                  .toString() +
              ": " +
              model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index)
                  .toString();
        })
      ],
      animate: false,
    );
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  static String value;

  CustomCircleSymbolRenderer();

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 100,
          bounds.height + 10),
      fill: Color.fromHex(code: '#666666'),
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(textel.TextElement(value, style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}
