// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/core/waveform_painters_ab.dart';

///InActiveWaveformPainter for the [PulseWaveform].
class PulseInActiveWaveformPainter extends InActiveWaveformPainter {
  PulseInActiveWaveformPainter({
    super.color = Colors.white,
    super.gradient,
    required super.samples,
    required super.sampleWidth,
    required super.borderColor,
    required super.borderWidth,
    required this.isRoundedRectangle,
    super.style = PaintingStyle.fill,
    required super.waveformAlignment,
  });

  final bool isRoundedRectangle;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = style
      ..color = color
      ..shader = gradient?.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = borderWidth > sampleWidth ? 0 : borderWidth;
    final alignPosition = size.height;

    if (isRoundedRectangle) {
      drawRoundedRectangles(canvas, alignPosition, paint, borderPaint);
    } else {
      drawRegularRectangles(canvas, alignPosition, paint, borderPaint);
    }
  }

  // ignore: long-parameter-list
  void drawRegularRectangles(
    Canvas canvas,
    double alignPosition,
    Paint paint,
    Paint borderPaint,
  ) {
    for (var i = 0; i < samples.length; i++) {
      final x = sampleWidth * i;
      final y = -1 * samples[i].abs();
      final rectangle = Rect.fromLTWH(x, alignPosition, sampleWidth, y * 2);

      //Draws the filled rectangles of the waveform.
      canvas
        ..drawRect(
          rectangle,
          paint,
        )
        //Draws the border for the rectangles of the waveform.
        ..drawRect(
          rectangle,
          borderPaint,
        );
    }
  }

  // ignore: long-parameter-list
  void drawRoundedRectangles(
      Canvas canvas, double alignPosition, Paint paint, Paint borderPaint) {
    final radius = Radius.circular(sampleWidth);
    for (var i = 0; i < samples.length; i++) {
      if (i.isEven) {
        final x = sampleWidth * i;
        final y = -1 * samples[i].abs();
        final rectangle = Rect.fromLTWH(x, alignPosition, sampleWidth, y  * 2);
        //Draws the filled rectangles of the waveform.
        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              rectangle,
              radius,
            ),
            paint,
          )
          //Draws the border for the rectangles of the waveform.
          ..drawRRect(
            RRect.fromRectAndRadius(
              rectangle,
              radius,
            ),
            borderPaint,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PulseInActiveWaveformPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return getShouldRepaintValue(oldDelegate) ||
        isRoundedRectangle != oldDelegate.isRoundedRectangle;
  }
}
