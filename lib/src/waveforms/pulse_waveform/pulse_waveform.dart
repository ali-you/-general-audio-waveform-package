import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/core/audio_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/active_waveform_painter.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/inactive_waveform_painter.dart';

/// [PulseWaveform] paints a waveform where each sample is represented as
/// rectangle block. It's inspired by the @soundcloud audio track on web.
///
/// {@tool snippet}
/// Example :
/// ```dart
/// PulseWaveform(
///   maxDuration: maxDuration,
///   elapsedDuration: elapsedDuration,
///   samples: samples,
///   height: 300,
///   width: MediaQuery.of(context).size.width,
/// )
///```
/// {@end-tool}
class PulseWaveform extends AudioWaveform {
  PulseWaveform({
    super.key,
    required super.samples,
    required super.height,
    required super.width,
    super.maxDuration,
    super.elapsedDuration,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blue,
    this.activeGradient,
    this.inactiveGradient,
    this.borderWidth = 1.0,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = Colors.white,
    super.showActiveWaveform = true,
    /// by default it is absolute. if you want to make each pulse paint in the half of its current height make it false
    super.absolute = true,
    super.invert = false,
    this.isRoundedRectangle = false
  }) : assert(
          borderWidth >= 0 && borderWidth <= 3.0,
          'BorderWidth must be between 0 and 3',
        );

  /// The color of the active waveform.
  final Color activeColor;

  /// The color of the inactive waveform.
  final Color inactiveColor;

  /// The gradient of the active waveform.
  final Gradient? activeGradient;

  /// The gradient of the inactive waveform.
  final Gradient? inactiveGradient;

  /// The width of the border of the waveform.
  final double borderWidth;

  /// The color of the active waveform border.
  final Color activeBorderColor;

  /// The color of the inactive waveform border.
  final Color inactiveBorderColor;

  /// If true then rounded rectangles are drawn instead of regular rectangles.
  final bool isRoundedRectangle;


  @override
  AudioWaveformState<PulseWaveform> createState() =>
      _PulseWaveformState();
}

class _PulseWaveformState extends AudioWaveformState<PulseWaveform> {
  @override
  Widget build(BuildContext context) {
    if (widget.samples.isEmpty) {
      return const SizedBox.shrink();
    }
    final processedSamples = this.processedSamples;
    final activeSamples = this.activeSamples;
    final showActiveWaveform = this.showActiveWaveform;
    final waveformAlignment = this.waveformAlignment;
    final sampleWidth = this.sampleWidth;

    return Stack(
      children: [
        RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: PulseInActiveWaveformPainter(
              samples: processedSamples,
              color: widget.inactiveColor,
              gradient: widget.inactiveGradient,
              waveformAlignment: waveformAlignment,
              borderColor: widget.inactiveBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
              isRoundedRectangle: widget.isRoundedRectangle,
            ),
          ),
        ),
        if (showActiveWaveform)
          CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: PulseActiveWaveformPainter(
              color: widget.activeColor,
              activeSamples: activeSamples,
              gradient: widget.activeGradient,
              waveformAlignment: waveformAlignment,
              borderColor: widget.activeBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
              isRoundedRectangle: widget.isRoundedRectangle,
            ),
          ),
      ],
    );
  }
}
