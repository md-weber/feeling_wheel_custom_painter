import 'dart:math';

import 'package:feeling_wheel_custom_painter/colors.dart';
import 'package:flutter/material.dart';

class Feeling {
  final String text;
  final bool active;

  Feeling(this.text, this.active);
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final feelingList = [Feeling("Annoyed", false)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              DesignColors.backgroundLeftSide,
              DesignColors.backgroundRightSide
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 25,
              top: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome Jamie,",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    "How are you feeling?",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: WheelOfFeelingPainter(),
            ),
            Positioned(
                right: 75,
                top: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children:[
                    Row(
                      children: const [
                        Text('• ', style: TextStyle(color: Colors.orangeAccent, fontSize: 24),),
                        Text(
                          "Annoyed",
                          style: TextStyle(
                            color: DesignColors.textColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class WheelOfFeelingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 10, size.height / 2);

    for (var i = 0; i < 10; i++) {
      var starWidth = Random().nextDouble() * size.width;
      var starHeight = Random().nextDouble() * size.height;
      var starPaint = Paint()..color = Colors.white;
      canvas.drawCircle(Offset(starWidth, starHeight), 1, starPaint);
    }

    var icon = Paint()
      ..color = DesignColors.textColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var activeIcon = Paint()
      ..color = DesignColors.activeTextColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var outerCircle = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.yellow,
          Colors.orange,
          Colors.red,
          Colors.deepPurple,
          Colors.blue
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 300))
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    var innerCircle = Paint()
      ..color = DesignColors.innerCircleBlue
      ..style = PaintingStyle.fill;

    var midCirclePaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          DesignColors.midCircleLightBlue,
          DesignColors.midCircleDarkBlue
        ],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2.3))
      ..style = PaintingStyle.fill;

    var separatorColor = Paint()
      ..strokeWidth = 3
      ..color = DesignColors.innerCircleBlue
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(130, size.height / 2)
      ..lineTo(160, size.height / 2 - 10)
      ..lineTo(130, size.height / 2 - 20)
      ..close();

    // Inner Circle Text
    var innerCircleTextSpan = const TextSpan(
        style: TextStyle(color: DesignColors.textColor),
        text: "A response to repeated failures to overcome an obstacle");

    var textPainter = TextPainter(
        text: innerCircleTextSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);

    textPainter.layout(maxWidth: 125);

    // Joy
    var joyWidth = size.width / 2 - 147;
    var joyHeight = size.height / 2 - 142;
    var joyCenter = Offset(joyWidth + 5, joyHeight);
    var joySmiley = Path()
      ..moveTo(joyWidth, joyHeight)
      ..lineTo(joyWidth + 10, joyHeight)
      ..arcToPoint(Offset(joyWidth, joyHeight),
          radius: const Radius.circular(5))
      ..close();

    var joyTextSpan = const TextSpan(
      style: TextStyle(color: DesignColors.textColor),
      text: "Joy",
    );
    var joyTextPainter = TextPainter(
        text: joyTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    joyTextPainter.layout();

    // Interest
    var interestWidth = size.width / 2 - 55;
    var interestHeight = size.height / 2 - 95;
    var interestCenter = Offset(interestWidth + 5, interestHeight);
    var interestSmiley = Path()
      ..moveTo(interestWidth + 2, interestHeight + 5)
      ..lineTo(interestWidth + 9, interestHeight + 3)
      ..close();
    var interestTextSpan = const TextSpan(
      style: TextStyle(color: DesignColors.textColor),
      text: "Interest",
    );

    var interestTextPainter = TextPainter(
        text: interestTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    interestTextPainter.layout();

    // Anger
    var angerWidth = size.width / 2 - 35;
    var angerHeight = size.height / 2 + 10;
    var angerCenter = Offset(angerWidth + 5, angerHeight);

    var angerEyeLeft = Path()
      ..moveTo(angerWidth, angerHeight - 5)
      ..lineTo(angerWidth + 3, angerHeight - 2);
    var angerEyeRight = Path()
      ..moveTo(angerWidth + 10, angerHeight - 5)
      ..lineTo(angerWidth + 7, angerHeight - 2);

    var angerMouth = Path()
      ..moveTo(angerWidth, angerHeight + 3)
      ..arcToPoint(Offset(angerWidth + 10, angerHeight + 3),
          radius: const Radius.circular(10));
    var angerTextSpan = const TextSpan(
      style: TextStyle(color: DesignColors.activeTextColor),
      text: "Anger",
    );
    var angerTextPainter = TextPainter(
        text: angerTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    angerTextPainter.layout();

    // Disgust
    var disgustWidth = size.width / 2 - 95;
    var disgustHeight = size.height / 2 + 105;
    var disgustCenter = Offset(disgustWidth + 5, disgustHeight);
    var disgustSmiley = Path()
      ..moveTo(disgustWidth, disgustHeight + 3)
      ..arcToPoint(Offset(disgustWidth + 10, disgustHeight + 3),
          radius: const Radius.circular(6));
    var disgustTextSpan = const TextSpan(
      style: TextStyle(color: DesignColors.textColor),
      text: "Disgust",
    );
    var disgustTextPainter = TextPainter(
        text: disgustTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    disgustTextPainter.layout();

    // Sadness
    var sadnessTextSpan = const TextSpan(
      style: TextStyle(color: DesignColors.textColor),
      text: "Sadness",
    );
    var sadnessTextPainter = TextPainter(
        text: sadnessTextSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    sadnessTextPainter.layout();

    canvas.drawCircle(center, size.width / 2.3, midCirclePaint);
    canvas.drawLine(center, const Offset(0, 250), separatorColor);
    canvas.drawLine(center, const Offset(125, 275), separatorColor);
    canvas.drawLine(center, const Offset(200, 375), separatorColor);
    canvas.drawLine(center, const Offset(175, 525), separatorColor);
    canvas.drawLine(center, const Offset(75, 600), separatorColor);
    canvas.drawCircle(center, 100, innerCircle);
    canvas.drawCircle(center, size.width / 2.25, outerCircle);
    textPainter.paint(canvas, Offset(center.dx - 40, center.dy - 35));
    joyTextPainter.paint(canvas, Offset(center.dx, center.dy - 130));
    interestTextPainter.paint(canvas, Offset(center.dx + 85, center.dy - 80));
    angerTextPainter.paint(canvas, Offset(center.dx + 105, center.dy + 25));
    disgustTextPainter.paint(canvas, Offset(center.dx + 40, center.dy + 115));
    sadnessTextPainter.paint(canvas, Offset(center.dx - 50, center.dy + 130));
    canvas.drawPath(path, innerCircle);
    canvas.drawPath(joySmiley, icon);
    canvas.drawPath(interestSmiley, icon);
    canvas.drawPath(angerMouth, activeIcon);
    canvas.drawPath(angerEyeLeft, activeIcon);
    canvas.drawPath(angerEyeRight, activeIcon);
    canvas.drawPath(disgustSmiley, icon);
    canvas.drawCircle(joyCenter, 10, icon);
    canvas.drawCircle(interestCenter, 10, icon);
    canvas.drawCircle(angerCenter, 10, activeIcon);
    canvas.drawCircle(disgustCenter, 10, icon);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
