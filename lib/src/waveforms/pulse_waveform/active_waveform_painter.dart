// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/core/waveform_painters_ab.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';

///ActiveWaveformPainter for the [PulseWaveform]
class PulseActiveWaveformPainter extends ActiveWaveformPainter {
  PulseActiveWaveformPainter({
    required super.color,
    required super.activeSamples,
    required super.waveformAlignment,
    required super.sampleWidth,
    required super.borderColor,
    required super.borderWidth,
    required this.isRoundedRectangle,
    super.gradient,
    super.style = PaintingStyle.fill,
  });
  final bool isRoundedRectangle;

  @override
  void paint(Canvas canvas, Size size) {
    final activeTrackPaint = Paint()
      ..style = style
      ..color = color
      ..shader = gradient?.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = borderWidth;
    final alignPosition = size.height;

    if (isRoundedRectangle) {
      drawRoundedRectangles(
          canvas, alignPosition, activeTrackPaint, borderPaint);
    } else {
      drawRegularRectangles(
          canvas, alignPosition, activeTrackPaint, borderPaint);
    }
  }

  // ignore: long-parameter-list
  void drawRegularRectangles(
      Canvas canvas, double alignPosition, Paint paint, Paint borderPaint) {
    for (var i = 0; i < activeSamples.length; i++) {
      final x = sampleWidth * i;
      final y = -1 * activeSamples[i].abs();
      //Draws the filled rectangles of the waveform.
      canvas
        ..drawRect(
          Rect.fromLTWH(x, alignPosition, sampleWidth, y),
          paint,
        )
        //Draws the border for the rectangles of the waveform.
        ..drawRect(
          Rect.fromLTWH(x, alignPosition, sampleWidth, y),
          borderPaint,
        );
    }
  }

  // ignore: long-parameter-list
  void drawRoundedRectangles(
      Canvas canvas, double alignPosition, Paint paint, Paint borderPaint) {
    for (var i = 0; i < activeSamples.length; i++) {
      if (i.isEven) {
        final x = sampleWidth * i;
        final y = -1 * activeSamples[i].abs();

        //Draws the filled rectangles of the waveform.
        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, alignPosition, sampleWidth, y),
              Radius.circular(x),
            ),
            paint,
          )
          //Draws the border for the rectangles of the waveform.
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, alignPosition, sampleWidth, y),
              Radius.circular(x),
            ),
            borderPaint,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PulseActiveWaveformPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return getShouldRepaintValue(oldDelegate) ||
        isRoundedRectangle != oldDelegate.isRoundedRectangle;
  }
}
