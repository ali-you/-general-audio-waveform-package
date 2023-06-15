import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/data/extraction/wave_source.dart';

import 'data/scaling/scaling_algorithm.dart';

class AudioWaveform {
  final double _duration;
  final ScalingAlgorithm _algorithm;
  final WaveSource _source;


  AudioWaveform(this._duration, this._algorithm, this._source);

  Widget fromPath(String path) {
    return Container();
  }
}
