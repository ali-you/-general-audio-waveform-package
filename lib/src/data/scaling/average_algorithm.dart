import 'package:general_audio_waveforms/src/data/scaling/scaling_algorithm.dart';

/// [AverageAlgorithm] maps some samples to one buy computing their average to make a list of [maxSample] doubles.
class AverageAlgorithm extends ScalingAlgorithm {
  @override
  List<double> execute() {
    List<double> newSamples = [];
    double sum = 0.0;
    int j = 1;
    var blockSize = (samples.length / maxSample).round();
    for (int i = 0; i < samples.length; i++) {
      var sample = samples.elementAt(i) ;
      sum += sample;
      if (j == blockSize) {
        newSamples.add(sum / blockSize);
        sum = 0.0;
        j = 0;
      }
      j++;
    }
    return newSamples;
  }

  AverageAlgorithm({required super.samples, required super.maxSample});
}
