import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/data/scaling/scaling_algorithm.dart';

class AudioWaveform {
  final double _duration;
  final ScalingAlgorithm _algorithm;


  AudioWaveform(this._duration, this._algorithm);

  Widget fromLocalPath(String path) {
    return Container();
  }

  Widget fromUrl(String url) {
    return Container();
  }

  Future<Widget> fromAsset(String assetPath) async {
    // final byteData = await rootBundle.load(assetPath);
    // final tempDir = await getTemporaryDirectory();
    // final file = File('${tempDir.path}/temp.mp3');
    // await file.writeAsBytes(byteData.buffer.asUint8List());
    return Container();
  }

  Widget fromList(List<double> samples){
    return Container();
  }
}
