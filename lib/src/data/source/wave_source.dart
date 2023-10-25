abstract class WaveSource {
  List<double> samples;

  WaveSource({this.samples = const []});

  Future<List<double>> evaluate();
}
