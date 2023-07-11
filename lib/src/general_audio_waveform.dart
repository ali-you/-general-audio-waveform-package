import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/data/common/scaling_algorithm_type.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/median_algorithm.dart';
import 'package:general_audio_waveforms/src/data/source/wave_source.dart';
import 'package:general_audio_waveforms/src/waveforms/common/waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/common/waveform_style.dart';
import 'package:general_audio_waveforms/src/waveforms/common/waveform_type.dart';

// ignore: must_be_immutable
class GeneralAudioWaveform extends StatefulWidget {
  final ScalingAlgorithmType scalingAlgorithm;
  final WaveformType waveformType;
  final WaveformStyle? waveformStyle;
  final Duration maxDuration;
  final Duration elapsedDuration;
  Function(Duration) elapsedIsChanged;
  final WaveSource source;
  int maxSamples;

  GeneralAudioWaveform(
      {super.key,
      this.scalingAlgorithm = ScalingAlgorithmType.average,
      this.waveformType = WaveformType.pulse,
        this.waveformStyle,
        required this.maxDuration,
        required this.elapsedDuration,
        required this.elapsedIsChanged,
      required this.source,
      this.maxSamples = 100});

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
      width: widget.waveformStyle?.width,
      height: widget.waveformStyle?.height,
      child: Stack(
        children: [
          Waveform(elapsedDuration: widget.elapsedDuration, maxDuration: widget.maxDuration, waveformType: widget.waveformType, waveformStyle: widget.waveformStyle, samples: samples),
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
                // divisions: (widget.maxDuration).inMilliseconds,
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
    var tempSamples = await widget.source.samples;
    switch (widget.scalingAlgorithm) {
      case ScalingAlgorithmType.average:
        samples =
            AverageAlgorithm(samples: tempSamples, maxSample: widget.maxSamples)
                .execute();
        break;
      case ScalingAlgorithmType.median:
        samples =
            MedianAlgorithm(samples: tempSamples, maxSample: widget.maxSamples)
                .execute();
        break;
      default:
        samples = tempSamples;
    }
  }
}
