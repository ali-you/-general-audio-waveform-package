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
import 'data/decoder/decoder.dart';
import 'data/scaling/average_algorithm.dart';

// ignore: must_be_immutable
class GeneralAudioWaveform extends StatefulWidget {
  ScalingType algorithm;
  String path;
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
      this.algorithm = ScalingType.none,
      this.waveType = WaveformType.pulse,
      required this.path,
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
      this.showActiveWaveform = false,
      this.waveformAlignment = WaveformAlignment.center});

  @override
  State<GeneralAudioWaveform> createState() => _GeneralAudioWaveformState();
}

class _GeneralAudioWaveformState extends State<GeneralAudioWaveform> {
  List<double> samples = [];

  @override
  void initState() {
    setSamples();

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if (widget.elapsedDuration!.inMilliseconds < widget.maxDuration!.inMilliseconds) {
    //     setState(() {
    //       widget.elapsedDuration = widget.elapsedDuration! + const Duration(milliseconds: 500);
    //     });
    //   }
    // });

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
                    activeTrackColor: Colors.red.withOpacity(0.5),
                    inactiveTrackColor: Colors.transparent,
                    overlayShape: SliderComponentShape.noThumb)),
            child: Slider(
                value: ((widget.elapsedDuration).inMilliseconds).toDouble(),
                max: ((widget.maxDuration).inMilliseconds).toDouble(),
                divisions: (widget.maxDuration).inMilliseconds,
                onChanged: (double value) {
                  setState(() {
                    widget.elapsedIsChanged(
                        Duration(milliseconds: value.toInt()));
                  });
                }),
          ),
        ],
      ),
    );
  }

  Future<void> setSamples() async {
    var tempSamples = await Decoder(path: widget.path).extract();
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
          // elapsedDuration: widget.elapsedDuration,
          elapsedDuration: Duration(milliseconds: 500),
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
