import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/median_algorithm.dart';
import 'package:general_audio_waveforms/src/util/waveform_alignment.dart';
import 'package:general_audio_waveforms/src/waveforms/common/waveform.dart';

// ignore: must_be_immutable
class GeneralAudioWaveform extends StatefulWidget {
  final ScalingAlgorithmType scalingAlgorithmType;
  final WaveformType waveformType;
  final WaveformStyle? waveformStyle;
  final WaveSource source;
  final int? maxSamples;
  final double? height;
  final double? width;

  final Duration maxDuration;
  final Duration elapsedDuration;
  Function(Duration) elapsedIsChanged;
  final bool absolute;
  final bool invert;
  final bool showActiveWaveform;
  final WaveformAlignment waveformAlignment;

  GeneralAudioWaveform(
      {super.key,
      this.scalingAlgorithmType = ScalingAlgorithmType.average,
      this.waveformType = WaveformType.pulse,
      required this.source,
      this.maxSamples = 100,
      this.height,
      this.width,
      required this.maxDuration,
      required this.elapsedDuration,
      required this.elapsedIsChanged,
      this.absolute = false,
      this.invert = false,
      this.showActiveWaveform = true,
      this.waveformAlignment = WaveformAlignment.center,
      this.waveformStyle});

  @override
  State<GeneralAudioWaveform> createState() => _GeneralAudioWaveformState();
}

class _GeneralAudioWaveformState extends State<GeneralAudioWaveform> {
  List<double>? samples;

  @override
  void initState() {
    setSamples();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.sizeOf(context).width * 0.5,
      height: widget.height ?? 50,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Waveform(
              waveformType: widget.waveformType,
              elapsedDuration: widget.elapsedDuration,
              maxDuration: widget.maxDuration,
              samples: samples),
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
                onChanged: (double value) {
                  widget
                      .elapsedIsChanged(Duration(milliseconds: value.toInt()));
                }),
          ),
        ],
      ),
    );
  }

  Future<void> setSamples() async {
    await widget.source.evaluate();
    List<double> tempSamples = [];
    setState(() {
      tempSamples = widget.source.samples;
    });
    switch (widget.scalingAlgorithmType) {
      case ScalingAlgorithmType.none:
        samples = tempSamples;
        break;

      case ScalingAlgorithmType.average:
        samples = AverageAlgorithm(
                samples: tempSamples, maxSample: widget.maxSamples ?? 100)
            .execute();
        break;
      case ScalingAlgorithmType.median:
        samples = MedianAlgorithm(
                samples: tempSamples, maxSample: widget.maxSamples ?? 100)
            .execute();
        break;
    }
  }
}
