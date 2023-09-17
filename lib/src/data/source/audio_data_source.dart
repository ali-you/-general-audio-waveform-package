import 'wave_source.dart';

class AudioDateSource extends WaveSource {
  AudioDateSource({required List<double> samples}) : super(samples: samples);

  @override
  Future<void> evaluate() {
    // TODO: implement evaluate -> scaling ??
    throw UnimplementedError();
  }
}
