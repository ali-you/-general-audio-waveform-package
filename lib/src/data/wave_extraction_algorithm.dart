/// There are different ways to extract waveform from target audio file
/// Here we implemented some of these
/// [WaveNormalizationAlgorithm] is the base Strategy . To Use each algorithm you can add an object of your desired Strategy of below options.
///
/// {@tool snippet}
/// Example :
/// ```dart
///   //TODO
///```
/// {@end-tool}
abstract class WaveNormalizationAlgorithm {
  /// list of samples before normalization
  List<double> samples;

  /// to reduce number of samples to your desired length
  int maxSample;

  WaveNormalizationAlgorithm({required this.samples, required this.maxSample});

  List<double> execute();
}

/// [AverageAlgorithm] maps each [maxSample] samples to one buy computing their average.
class AverageAlgorithm extends WaveNormalizationAlgorithm {
  @override
  List<double> execute() {
    List<double> newSamples = [];
    for (int i = 0; i < samples.length; i++) {
      double sum = 0.0;

      /// a default value of 32 bits per sample = 2^31 = 2147483648
      var sample = -1 * samples.elementAt(i).abs() / 2147483648.0;
      sum += sample;
      if (i % maxSample == maxSample - 1) {
        newSamples.add(sum / maxSample);
        sum = 0.0;
      }
    }
    return newSamples;
  }

  AverageAlgorithm({required super.samples, required super.maxSample});
}

/// [PeakAlgorithm] finds the maximum absolute value of each block of samples with length of [maxSample]
class PeakAlgorithm extends WaveNormalizationAlgorithm {
  @override
  List<double> execute() {
    //TODO -> it is not optimized :) --> no no it is wrong :)))
    // ///Find the maximum absolute value
    // double maxAbsValue =
    //     samples.map((value) => value.abs()).reduce((a, b) => a > b ? a : b);
    //
    // ///Divide each element by the maximum absolute value
    // List<double> normalizedList =
    //     samples.map((value) => value / maxAbsValue).toList();
    //
    // ///Resize the list to the desired length
    // List<double> newSamples = List<double>.filled(maxSample, 0);
    // double scaleFactor = (samples.length - 1) / (maxSample - 1);
    // for (int i = 0; i < maxSample; i++) {
    //   int index = (i * scaleFactor).round();
    //   newSamples.add(normalizedList[index]);
    // }

    // return newSamples;
    return [];
  }

  PeakAlgorithm({required super.samples, required super.maxSample});
}

// class LUFSAlgorithm extends WaveNormalizationAlgorithm {
//   @override
//   List<double> execute() {
//
//     return [];
//   }
//
//   LUFSAlgorithm({required super.samples, required super.maxSample});
// }
