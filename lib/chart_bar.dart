import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/chart_bar.dart';

class ChartBar extends StatelessWidget {
  final ChartBarModel chartBarModel;

  ChartBar({this.chartBarModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FittedBox(
          child: Text(NumberFormat.compactSimpleCurrency(
                  locale: 'pl_PL', decimalDigits: 0)
              .format(chartBarModel.expensesAmount)),
        ),
        CustomPaint(
            size: Size(10, 100),
            painter: ChartBarPainter(
                context: context,
                expensesPercentage: chartBarModel.expensesPercentage)),
        Text('${chartBarModel.weekdayLiteral}')
      ],
    );
  }
}

class ChartBarPainter extends CustomPainter {
  final double expensesPercentage;
  final BuildContext context;
  final Paint backgroundPaint = Paint()..color = Colors.white70;
  final Paint percentagePaint;
  final Paint borderPaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  final Radius globalRadius = Radius.circular(5);

  ChartBarPainter({this.expensesPercentage, this.context})
      : this.percentagePaint = Paint()..color = Theme.of(context).primaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), globalRadius);
    final percentageOffset = (100 - expensesPercentage) / 100 * size.height;
    final percentageRect = RRect.fromLTRBAndCorners(
        0, percentageOffset, size.width, size.height,
        bottomLeft: globalRadius,
        bottomRight: globalRadius,
        topLeft: percentageOffset <= 1 ? globalRadius : Radius.zero,
        topRight: percentageOffset <= 1 ? globalRadius : Radius.zero);

    canvas.drawRRect(backgroundRect, backgroundPaint);
    canvas.drawRRect(percentageRect, percentagePaint);
    canvas.drawRRect(backgroundRect, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      (oldDelegate as ChartBarPainter).expensesPercentage != expensesPercentage;
}
