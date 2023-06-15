
///
///
/// [Decoder] is the base Strategy . To Use each extraction you can add an object of your desired Strategy of below options.
///
/// {@tool snippet}
/// Example :
/// ```dart
///   //TODO
///```
/// {@end-tool}
abstract class Decoder {

  /// Local Path
  final String path;

  Decoder({required this.path});

  Future<List<double>> extract() ;
}
