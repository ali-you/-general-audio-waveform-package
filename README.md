# General Audio Waveforms

General Audio Waveforms is a UI package for adding audio waveforms to your Flutter apps. This package is a customization of the flutter_audio_waveforms package available on pub.dev.

## Features

- Curved polygon waveform
- Polygon waveform
- Pulse waveform
- Rectangle waveform
- Squiggly waveform

You can choose the source of the waveform from the following options:

- AudioFileSource
- AudioNetworkSource
- AudioAssetSource
- AudioDateSource

The package also provides scaling options to adjust the number of data points shown in the waveform. You can use the average or median scaler to create buckets based on the size of the actual data and your desired size. The average or median of each bucket will be used as a representative in the final waveform.

## Getting Started

To start using the General Audio Waveforms package, follow these steps:

1. Add the package to your `pubspec.yaml` file:

  general_audio_waveforms: ^0.0.3


2. Import the package in your Dart code:

  dart import 'package:general_audio_waveforms/general_audio_waveforms.dart';


## Usage

```dart
GeneralAudioWaveform(
  scalingAlgorithmType: ScalingAlgorithmType.average,
  waveformType: WaveformType.pulse,
  maxDuration: maxDuration,
  elapsedDuration: elapsedDuration,
  elapsedIsChanged: (newTime){
    setState(() {
      elapsedDuration = newTime;
    });
  },
  // source: AudioAssetSource(assetName: "/assets/sample.mp3"),
  source: AudioFileSource(path: path),
),
```
For more examples and detailed usage instructions, refer to the example directory in the package repository.


## License

This package is released under the MIT License. See the [LICENSE](https://github.com/your-package-repo/LICENSE) file for more details.

## Contributions

We welcome contributions from the community. If you have any suggestions, bug reports, or feature requests, please open an issue on the [GitHub repository](https://github.com/your-package-repo).
