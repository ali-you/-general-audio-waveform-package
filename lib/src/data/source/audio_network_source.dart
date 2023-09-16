import 'wave_source.dart';

class AudioNetworkSource extends WaveSource {
  final String path;

  AudioNetworkSource({required this.path});

  @override
  Future<List<double>> get samples async {
    _samples = [];

    return _samples;
  }
}