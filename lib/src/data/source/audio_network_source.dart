import 'wave_source.dart';

class AudioNetworkSource extends WaveSource {
  final String path;

  AudioNetworkSource({required this.path});

  @override
  Future<List<double>> evaluate() async {
    samples = [];
    // TODO: implement this method
    return [];
  }
}
