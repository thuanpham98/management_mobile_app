import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedRect extends CustomPainter {
  Color? completeColor;
  double? completePercent;
  double? width;
  double? rounded;

  double? arcDistance;
  double? xLineDistance;

  double? yLineDistance;

  double? totalDistance;
  double? neededDistance;
  double? quarterRadians = (2 * pi) / 4;
  Size? _size;
  Paint? complete;
  Paint? line;

  RoundedRect(
    {this.completeColor, this.completePercent, this.width, this.rounded});

  void drawArc(Canvas canvas, int quarterIndex) {
    var beginAngle = [pi, -pi / 2, 0.0, pi / 2];
    var offsetArc = [
      Offset(rounded!, rounded!),
      Offset(_size!.width - rounded!, rounded!),
      Offset(_size!.width - rounded!, _size!.height - rounded!),
      Offset(rounded!, _size!.height - rounded!)
    ];
    var minDistMap = [
      0.0,
      arcDistance! + xLineDistance!,
      arcDistance! * 2 + xLineDistance! + yLineDistance!,
      arcDistance! * 3 + xLineDistance! * 2 + yLineDistance!
    ];
    var minDist = minDistMap[quarterIndex];
    var maxDist = minDistMap[quarterIndex] + arcDistance!;
    var angle = 0.0;
    if (neededDistance! >= maxDist) {
      angle = quarterRadians!;
    } else if (neededDistance! > minDist) {
      angle = (neededDistance! - minDist) / arcDistance! * quarterRadians!;
    }
    if (angle > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: offsetArc[quarterIndex], radius: rounded!),
        beginAngle[quarterIndex],
        angle,
        false,
        complete!);
    }
  }

  void drawLine(Canvas canvas, int lineIndex) {
    var minDistMap = [
      arcDistance,
      2 * arcDistance! + xLineDistance!,
      3 * arcDistance! + xLineDistance! + yLineDistance!,
      4 * arcDistance! + 2 * xLineDistance! + yLineDistance!
    ];
    var maxDistMap = [
      minDistMap[0]! + xLineDistance!,
      minDistMap[1]! + yLineDistance!,
      minDistMap[2]! + xLineDistance!,
      minDistMap[3]! + yLineDistance!,
    ];
    var minDist = minDistMap[lineIndex];
    var maxDist = maxDistMap[lineIndex];
    var mapBeginX = [rounded, _size!.width, _size!.width - rounded!, 0.0];
    var mapEndX = [_size!.width - rounded!, _size!.width, rounded, 0.0];
    var mapBeginY = [0.0, rounded, _size!.height, _size!.height - rounded!];
    var mapEndY = [0.0, _size!.height - rounded!, _size!.height, rounded];
    var applyForX = [true, false, true, false];
    Offset? p1, p2;

    if (neededDistance! >= maxDist) {
      p1 = Offset(mapBeginX[lineIndex]!, mapBeginY[lineIndex]!);
      p2 = Offset(mapEndX[lineIndex]!, mapEndY[lineIndex]!);
    } else if (neededDistance! > minDist!) {
      var dist = neededDistance! - minDist;
      p1 = Offset(mapBeginX[lineIndex]!, mapBeginY[lineIndex]!);
      if (applyForX[lineIndex]) {
        if (lineIndex == 2) {
          p2 = Offset(
            (xLineDistance! - dist) + mapEndX[lineIndex]!, mapEndY[lineIndex]!);
        } else {
          p2 = Offset(
            mapEndX[lineIndex]! - (xLineDistance! - dist), mapEndY[lineIndex]!);
        }
      } else {
        if (lineIndex == 3) {
          p2 = Offset(
            mapEndX[lineIndex]!, (yLineDistance! - dist) + mapEndY[lineIndex]!);
        } else {
          p2 = Offset(
            mapEndX[lineIndex]!, mapEndY[lineIndex]! - (yLineDistance! - dist));
        }
      }
    }
    if (p1 != null && p2 != null) {
      canvas.drawLine(p1, p2, complete!);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    complete = Paint()
      ..color = completeColor!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, width! / 8)
      ..strokeWidth = width!;

    _size = size;

    arcDistance = 2 * rounded! * pi / 4;
    xLineDistance = size.width - 2 * rounded!;
    yLineDistance = size.height - 2 * rounded!;
    totalDistance = xLineDistance! * 2 + yLineDistance! * 2 + arcDistance! * 4;
    neededDistance = totalDistance! * completePercent! / 100.0;

    drawArc(canvas, 0);
    drawLine(canvas, 0);
    drawArc(canvas, 1);
    drawLine(canvas, 1);
    drawArc(canvas, 2);
    drawLine(canvas, 2);
    drawArc(canvas, 3);
    drawLine(canvas, 3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ProgressContainer extends StatefulWidget {
  final Widget? child;
  final double rounded;
  final double strokeWidth;
  final Color color;
  final double percentage;

  ProgressContainer({Key? key,
    this.child,
    this.rounded = 0,
    this.strokeWidth = 1,
    this.color = Colors.redAccent,
    this.percentage = 0})
    : super(key: key);

  @override
  _ProgressContainerState createState() => _ProgressContainerState();
}

class _ProgressContainerState extends State<ProgressContainer>
  with TickerProviderStateMixin {
  double? _percentage;
  double? newPercentage;
  AnimationController? percentageAnimationController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _percentage = 0.0;
    });
    newPercentage = widget.percentage;
    percentageAnimationController = new AnimationController(
      vsync: this, duration: new Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {
          _percentage = lerpDouble(
            _percentage, newPercentage, percentageAnimationController!.value);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CustomPaint(
          foregroundPainter: RoundedRect(
            rounded: widget.rounded,
            completeColor: widget.color,
            completePercent: _percentage,
            width: widget.strokeWidth),
          child: Padding(
            padding: EdgeInsets.all(0),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(ProgressContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    newPercentage = widget.percentage;
    if (oldWidget.percentage != widget.percentage && widget.percentage == 0) {
      _percentage = 0;
      percentageAnimationController?.reset();
    }
    percentageAnimationController?.forward(from: 0.0);
  }

  @override
  void dispose() {
    if (percentageAnimationController?.status == AnimationStatus.forward) {
      percentageAnimationController?.notifyStatusListeners(AnimationStatus.dismissed);
    }
    percentageAnimationController?.dispose();
    super.dispose();
  }
}
