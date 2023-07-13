import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/median_algorithm.dart';

class GeneralAudioWaveformData {
  final WaveSource source;
  final ScalingAlgorithmType scalingAlgorithmType;
  final int? maxSamples;

  GeneralAudioWaveformData(
      {required this.source,
      this.scalingAlgorithmType = ScalingAlgorithmType.average, this.maxSamples});

  Future<List<double>?> getData() async {
    List<double>? orgSamples = await source.samples;
    List<double>? res;
    switch (scalingAlgorithmType) {
      case ScalingAlgorithmType.none:
        res = orgSamples;
        break;

      case ScalingAlgorithmType.average:
        res =
            AverageAlgorithm(samples: orgSamples, maxSample: maxSamples ?? 100)
                .execute();
        break;
      case ScalingAlgorithmType.median:
        res =
            MedianAlgorithm(samples: orgSamples, maxSample: maxSamples ?? 100)
                .execute();
        break;

    }
    return res;
  }
}
