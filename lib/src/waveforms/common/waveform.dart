import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:general_audio_waveforms/src/waveforms/curved_polygon_waveform/curved_polygon_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/polygon_waveform/polygon_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/rectangle_waveform/rectangle_waveform.dart';

class Waveform extends StatelessWidget {
  const Waveform(
      {Key? key,
      required this.waveformType,
      this.waveformStyle,
        this.height,
        this.width,
      required this.elapsedDuration,
      required this.maxDuration,
      this.samples})
      : super(key: key);

  final WaveformType waveformType;
  final WaveformStyle? waveformStyle;
  final double? height;
  final double? width;
  final Duration maxDuration;
  final Duration elapsedDuration;
  final List<double>? samples;

  @override
  Widget build(BuildContext context) {
    switch (waveformType) {
      case WaveformType.pulse:
        return PulseWaveform(
          height: height ?? 100,
          width: width ?? MediaQuery.sizeOf(context).width * 0.5,
          inactiveColor: waveformStyle?.inactiveColor ?? Colors.black38,
          activeColor: waveformStyle?.activeColor ?? Colors.blueAccent,
          showActiveWaveform: waveformStyle?.showActiveWaveform ?? true,
          activeBorderColor: waveformStyle?.activeBorderColor ?? Colors.white,
          inactiveBorderColor:
              waveformStyle?.inactiveBorderColor ?? Colors.white,
          borderWidth: waveformStyle?.borderWidth ?? 0,
          isRoundedRectangle: waveformStyle?.isRoundedRectangle ?? false,
          elapsedDuration: elapsedDuration,
          maxDuration: maxDuration,
          absolute: waveformStyle?.absolute ?? false,
          activeGradient: waveformStyle?.activeGradient,
          inactiveGradient: waveformStyle?.inactiveGradient,
          invert: waveformStyle?.invert ?? false,
          samples: samples,
        );
      case WaveformType.rectangle:
        return RectangleWaveform(
          height: height ?? 100,
          width: width ?? MediaQuery.sizeOf(context).width * 0.5,
          inactiveColor: waveformStyle?.inactiveColor ?? Colors.black38,
          activeColor: waveformStyle?.activeColor ?? Colors.blueAccent,
          showActiveWaveform: waveformStyle?.showActiveWaveform ?? true,
          activeBorderColor: waveformStyle?.activeBorderColor ?? Colors.white,
          inactiveBorderColor:
              waveformStyle?.inactiveBorderColor ?? Colors.white,
          borderWidth: waveformStyle?.borderWidth ?? 0,
          isRoundedRectangle: waveformStyle?.isRoundedRectangle ?? false,
          elapsedDuration: elapsedDuration,
          maxDuration: maxDuration,
          absolute: waveformStyle?.absolute ?? false,
          activeGradient: waveformStyle?.activeGradient,
          inactiveGradient: waveformStyle?.inactiveGradient,
          invert: waveformStyle?.invert ?? false,
          samples: samples,
        );
      case WaveformType.curved:
        return CurvedPolygonWaveform(
          height: height ?? 100,
          width: width ?? MediaQuery.sizeOf(context).width * 0.5,
          inactiveColor: waveformStyle?.inactiveColor ?? Colors.black38,
          activeColor: waveformStyle?.activeColor ?? Colors.blueAccent,
          showActiveWaveform: waveformStyle?.showActiveWaveform ?? true,
          elapsedDuration: elapsedDuration,
          maxDuration: maxDuration,
          absolute: waveformStyle?.absolute ?? false,
          invert: waveformStyle?.invert ?? false,
          samples: samples,
        );
      case WaveformType.polygon:
        return PolygonWaveform(
          height: height ?? 100,
          width: width ?? MediaQuery.sizeOf(context).width * 0.5,
          inactiveColor: waveformStyle?.inactiveColor ?? Colors.black38,
          activeColor: waveformStyle?.activeColor ?? Colors.blueAccent,
          showActiveWaveform: waveformStyle?.showActiveWaveform ?? true,
          elapsedDuration: elapsedDuration,
          maxDuration: maxDuration,
          absolute: waveformStyle?.absolute ?? false,
          activeGradient: waveformStyle?.activeGradient,
          inactiveGradient: waveformStyle?.inactiveGradient,
          invert: waveformStyle?.invert ?? false,
          samples: samples,
        );
    }
  }
}
