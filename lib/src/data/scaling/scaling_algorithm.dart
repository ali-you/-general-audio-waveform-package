/// There are different ways to scale list of waves from target audio file to our desired length.
/// Here we implemented some of these.
/// [ScalingAlgorithm] is the base Strategy . To Use each algorithm you can add an object of your desired Strategy of below options.
///
/// {@tool snippet}
/// Example :
/// ```dart
///   //TODO
///```
/// {@end-tool}
abstract class ScalingAlgorithm {
  /// list of samples before normalization
  final List<double> samples;

  /// to reduce number of samples to your desired length
  final int maxSample;

  ScalingAlgorithm({required this.samples, required this.maxSample});

  List<double> execute();
}

enum ScalingType{
  average,median,none
}