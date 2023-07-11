import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/data/scaling/median_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/scaling_algorithm.dart';
import 'package:general_audio_waveforms/src/util/waveform_alignment.dart';
import 'package:general_audio_waveforms/src/waveforms/curved_polygon_waveform/curved_polygon_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/polygon_waveform/polygon_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/rectangle_waveform/rectangle_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/waveform_type.dart';
import 'data/scaling/average_algorithm.dart';
import 'data/source/wave_source.dart';

// ignore: must_be_immutable
class GeneralAudioWaveform extends StatefulWidget {
  ScalingType algorithm;
  WaveSource source;
  int maxSamples;
  WaveformType waveType;

  final Color activeColor;
  final Color inactiveColor;
  final Gradient? activeGradient;
  final Gradient? inactiveGradient;
  final double borderWidth;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final bool isRoundedRectangle;
  final double height;
  final double width;
  final Duration maxDuration;
  final Duration elapsedDuration;
  Function(Duration) elapsedIsChanged;
  final bool absolute;
  final bool invert;
  final bool showActiveWaveform;
  final WaveformAlignment waveformAlignment;

  GeneralAudioWaveform(
      {super.key,
      this.algorithm = ScalingType.average,
      this.waveType = WaveformType.pulse,
      required this.source,
      this.maxSamples = 100,
      this.activeColor = Colors.blueAccent,
      this.inactiveColor = Colors.black38,
      this.activeGradient,
      this.inactiveGradient,
      this.borderWidth = 0,
      this.activeBorderColor = Colors.white,
      this.inactiveBorderColor = Colors.white,
      this.isRoundedRectangle = false,
      required this.height,
      required this.width,
      required this.maxDuration,
      required this.elapsedDuration,
      required this.elapsedIsChanged,
      this.absolute = false,
      this.invert = false,
      this.showActiveWaveform = true,
      this.waveformAlignment = WaveformAlignment.center});

  @override
  State<GeneralAudioWaveform> createState() => _GeneralAudioWaveformState();
}

class _GeneralAudioWaveformState extends State<GeneralAudioWaveform> {
  List<double> samples = [];

  @override
  void initState() {
    setSamples();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          waveWidget(),
          Theme(
            data: ThemeData(
                sliderTheme: SliderThemeData(
                    thumbShape: SliderComponentShape.noOverlay,
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    overlayShape: SliderComponentShape.noThumb)),
            child: Slider(
                value: ((widget.elapsedDuration).inMilliseconds).toDouble(),
                max: ((widget.maxDuration).inMilliseconds).toDouble(),
                divisions: (widget.maxDuration).inMilliseconds,
                onChanged: (double value) {
                    widget.elapsedIsChanged(
                        Duration(milliseconds: value.toInt()));
                }),
          ),
        ],
      ),
    );
  }

  Future<void> setSamples() async {
    List<double> tempSamples = await widget.source.samples; // important (while merge)
    switch (widget.algorithm) {
      case ScalingType.average:
        samples =
            AverageAlgorithm(samples: tempSamples, maxSample: widget.maxSamples)
                .execute();
        break;
      case ScalingType.median:
        samples =
            MedianAlgorithm(samples: tempSamples, maxSample: widget.maxSamples)
                .execute();
        break;
      default:
        samples = tempSamples;
    }
  }

  Widget waveWidget() {
    switch (widget.waveType) {
      case WaveformType.pulse:
        return PulseWaveform(
          height: widget.height,
          width: widget.width,
          inactiveColor: widget.inactiveColor,
          activeColor: widget.activeColor,
          showActiveWaveform: widget.showActiveWaveform,
          activeBorderColor: widget.activeBorderColor,
          inactiveBorderColor: widget.inactiveBorderColor,
          borderWidth: widget.borderWidth,
          isRoundedRectangle: widget.isRoundedRectangle,
          elapsedDuration: widget.elapsedDuration,
          maxDuration: widget.maxDuration,
          absolute: widget.absolute,
          activeGradient: widget.activeGradient,
          inactiveGradient: widget.inactiveGradient,
          invert: widget.invert,
          samples: samples,
        );
      case WaveformType.rectangle:
        return RectangleWaveform(
            samples: samples, height: widget.height, width: widget.width);
      case WaveformType.curved:
        return CurvedPolygonWaveform(
            samples: samples, height: widget.height, width: widget.width);
      case WaveformType.polygon:
        return PolygonWaveform(
            samples: samples, height: widget.height, width: widget.width);
      default:
        return const SizedBox.shrink();
    }
  }
}
