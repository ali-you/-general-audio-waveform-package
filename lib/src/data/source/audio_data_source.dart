import 'wave_source.dart';

class AudioDateSource extends WaveSource {
  AudioDateSource({required super.samples});

  @override
  Future<void> evaluate() {
    // TODO: implement evaluate -> scaling ??
    throw UnimplementedError();
  }
}
