import 'package:flutter/material.dart';

import 'models/chart_bar.dart';

class ChartBar extends StatelessWidget {
  final ChartBarModel chartBarModel;

  ChartBar({this.chartBarModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('\$${chartBarModel.expensesAmount.toStringAsFixed(0)}'),
        CustomPaint(
            size: Size(10, 100),
            painter: ChartBarPainter(
                expensesPercentage: chartBarModel.expensesPercentage)),
        Text('${chartBarModel.weekdayLiteral}')
      ],
    );
  }
}

class ChartBarPainter extends CustomPainter {
  final double expensesPercentage;
  final Paint backgroundPaint = Paint();
  final Paint percentagePaint = Paint();
  final Radius globalRadius = Radius.circular(5);

  ChartBarPainter({this.expensesPercentage}) {
    backgroundPaint.color = Colors.amber;
    percentagePaint.color = Colors.deepOrange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), globalRadius);
    final percentageOffset = (100 - expensesPercentage) / 100 * size.height;
    final percentageRect = RRect.fromLTRBAndCorners(
        0, percentageOffset, size.width, size.height,
        bottomLeft: globalRadius,
        bottomRight: globalRadius,
        topLeft: percentageOffset == 0 ? globalRadius : Radius.zero,
        topRight: percentageOffset == 0 ? globalRadius : Radius.zero);

    canvas.drawRRect(backgroundRect, backgroundPaint);
    canvas.drawRRect(percentageRect, percentagePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      (oldDelegate as ChartBarPainter).expensesPercentage != expensesPercentage;
}
