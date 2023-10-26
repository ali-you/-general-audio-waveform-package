import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/general_audio_waveforms.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Audio Waveform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'General Audio Waveforms'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration elapsedTime = const Duration(seconds: 0);
  Duration maxDuration = const Duration(seconds: 150);

  String path = "/storage/emulated/0/Download/file_example_MP3_700KB.mp3";

  @override
  void initState() {Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedTime.inSeconds < maxDuration.inSeconds) {
        setState(() {
          elapsedTime += const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.mediaLibrary,
    ].request();
  }

  // Future<void> getData() async {
  //   debugPrint("ooops${await GeneralAudioWaveformData(source: AudioFileSource(path: path)).getData()}");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeneralAudioWaveform(
              scalingAlgorithmType: ScalingAlgorithmType.average,
              source: AudioAssetSource(path: "assets/sample.mp3"),
              // source: AudioDataSource(samples: [1,2,3,4,5,6,7,8,9,1,2,3,4,4,5,6,7,12,1,1,1,3,4,5,6,9]),
              maxSamples: 50,
              waveformType: WaveformType.pulse,
              maxDuration: maxDuration,
              elapsedDuration: elapsedTime,
              elapsedIsChanged: (d) {
                setState(() {
                  elapsedTime = d;
                });
              },
            ),

            // TextButton(
            //     onPressed: () {
            //       getData();
            //     },
            //     child: const Text("Get data"))
          ],
        ),
      ),
    );
  }
}
