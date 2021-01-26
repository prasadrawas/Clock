import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: Clock(),
        ),
      ),
    );
  }
}

class Clock extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center_coordinates = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    //clock circles canvas code
    var drawClockCircle = Paint()..color = Color(0xFF3B3737);

    var drawClockOutline = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    var drawClockCenter = Paint()..color = Colors.white;

    //clock hand canvas code
    var secHand = Paint()
      ..shader = RadialGradient(colors: [Colors.pink, Colors.orange])
          .createShader(
              Rect.fromCircle(center: center_coordinates, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHand = Paint()
      ..shader = RadialGradient(colors: [Colors.pinkAccent, Colors.blueAccent])
          .createShader(
              Rect.fromCircle(center: center_coordinates, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    var hourHand = Paint()
      ..shader = RadialGradient(colors: [Colors.pinkAccent, Colors.green])
          .createShader(
              Rect.fromCircle(center: center_coordinates, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    //second hand co-ordinates
    var secX = radius + 75 * cos(dateTime.second * 6 * pi / 180);
    var secY = radius + 75 * sin(dateTime.second * 6 * pi / 180);
    var sec_coordinates = Offset(secX, secY);

    //minute hand co-ordinates
    var minX = radius + 55 * cos(dateTime.minute * 6 * pi / 180);
    var minY = radius + 55 * sin(dateTime.minute * 6 * pi / 180);
    var min_coordinates = Offset(minX, minY);

    //minute hand co-ordinates
    var hourX = radius +
        40 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourY = radius +
        40 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hour_coordinates = Offset(hourX, hourY);

    //drawing clock canvas
    canvas.drawCircle(center_coordinates, radius, drawClockCircle);
    canvas.drawCircle(center_coordinates, radius, drawClockOutline);
    canvas.drawLine(center_coordinates, sec_coordinates, secHand);
    canvas.drawLine(center_coordinates, min_coordinates, minHand);
    canvas.drawLine(center_coordinates, hour_coordinates, hourHand);
    canvas.drawCircle(center_coordinates, radius / 12, drawClockCenter);

    //calculate dashesh co-ordinates

    var outerRadius = radius + 29;
    var innerRadius = radius + 20;

    var drawDashLines = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (double d = 0; d < 360; d += 12) {
      var x1 = centerX + innerRadius * cos(d * pi / 180);
      var y1 = centerY + innerRadius * sin(d * pi / 180);

      var x2 = centerX + outerRadius * cos(d * pi / 180);
      var y2 = centerX + outerRadius * sin(d * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), drawDashLines);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
