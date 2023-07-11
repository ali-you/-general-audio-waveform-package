import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/general_audio_waveform.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/scaling_algorithm.dart';
import 'package:general_audio_waveforms/src/data/source/wave_source.dart';
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
  Duration elapsedTime = const Duration(seconds:0);
  Duration elapsedTime2 = const Duration(seconds:0);
  Duration maxDuration = const Duration(seconds: 150);
  List<double> samples = [];

  // String path = "/storage/emulated/0/Download/sample2.mp3";
  String path = "/storage/emulated/0/Download/sample.mp3";
  // String path = "/sdcard/Download/sample.mp3";

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedTime.inSeconds < maxDuration.inSeconds) {
        setState(() {
          elapsedTime += const Duration(seconds: 1);
          elapsedTime2 += const Duration(seconds: 1);
        });
      }
      else{
        timer.cancel();
      }
    });
    super.initState();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.storage,
      // Permission.manageExternalStorage,
      // Permission.mediaLibrary,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    requestPermissions();
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            Spacer(),

            GeneralAudioWaveform(
              activeColor: Colors.red,
              algorithm: ScalingType.average,
              maxDuration: maxDuration,
              elapsedDuration: elapsedTime,
              elapsedIsChanged: (d){
                setState(() {
                  elapsedTime = d;
                });
              },
              source: AudioFileSource(path: path),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.5 ,maxSamples: 80,
            ),
            Spacer(),
            GeneralAudioWaveform(
              activeColor: Colors.blue,
              algorithm: ScalingType.average,
              maxDuration: maxDuration,
              elapsedDuration: elapsedTime2,
              elapsedIsChanged: (d){
                setState(() {
                  elapsedTime2 = d;
                });
              },
              source: AudioAssetSource(assetPath: "assets/sample.mp3"),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.5 ,maxSamples: 80,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
