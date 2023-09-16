import 'wave_source.dart';

class AudioDateSource extends WaveSource {
  @override
  Future<List<double>> get samples async {
    return _samples;
  }

  AudioDateSource(List<double> samples) {
    _samples = samples;
  }
}