import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/util/waveform_alignment.dart';

class WaveformStyle {
  final Color? activeColor;
  final Color? inactiveColor;
  final Gradient? activeGradient;
  final Gradient? inactiveGradient;
  final double? borderWidth;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final bool? isRoundedRectangle;
  final bool? absolute;
  final bool? invert;
  final bool? showActiveWaveform;
  final WaveformAlignment? waveformAlignment;

  WaveformStyle(
      {this.activeColor,
      this.inactiveColor,
      this.activeGradient,
      this.inactiveGradient,
      this.borderWidth,
      this.activeBorderColor,
      this.inactiveBorderColor,
      this.isRoundedRectangle,
      this.absolute,
      this.invert,
      this.showActiveWaveform,
      this.waveformAlignment = WaveformAlignment.center});
}
