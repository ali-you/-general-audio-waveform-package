import 'wave_source.dart';

class AudioDataSource extends WaveSource {
  AudioDataSource({required super.samples});

  @override
  Future<List<double>> evaluate() async {
    return super.samples;
    // throw UnimplementedError();
  }
}
