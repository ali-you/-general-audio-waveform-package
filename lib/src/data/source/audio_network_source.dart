import 'wave_source.dart';

class AudioNetworkSource extends WaveSource {
  final String path;

  AudioNetworkSource({required this.path});

  @override
  Future<void> evaluate() async {
    samples = [];
    // TODO: implement this method
  }
}
