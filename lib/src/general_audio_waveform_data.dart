import 'package:general_audio_waveforms/general_audio_waveforms.dart';

class GeneralAudioWaveformData {
  final WaveSource source;
  final ScalingAlgorithmType scalingAlgorithmType;
  final int? maxSamples;

  GeneralAudioWaveformData(
      {required this.source,
      this.scalingAlgorithmType = ScalingAlgorithmType.average,
      this.maxSamples});

  // Future<List<double>?> getData() async {
  //   await source.evaluate();
  //   List<double>? orgSamples = source.samples;
  //   List<double>? res;
  //   switch (scalingAlgorithmType) {
  //     case ScalingAlgorithmType.none:
  //       res = orgSamples;
  //       break;
  //
  //     case ScalingAlgorithmType.average:
  //       res =
  //           AverageAlgorithm(samples: orgSamples, maxSample: maxSamples ?? 100)
  //               .execute();
  //       break;
  //     case ScalingAlgorithmType.median:
  //       res = MedianAlgorithm(samples: orgSamples, maxSample: maxSamples ?? 100)
  //           .execute();
  //       break;
  //   }
  //   return res;
  // }

}
