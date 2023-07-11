import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/general_audio_waveform.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/decoder/decoder.dart';
import 'package:general_audio_waveforms/src/data/scaling/scaling_algorithm.dart';
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
  Duration elapsedTime = const Duration(seconds:7);
  Duration maxDuration = const Duration(milliseconds: 100000);
  List<double> samples = [];

  // String path = "/storage/emulated/0/Download/file_example_MP3_700KB.mp3";
  String path = "/storage/emulated/0/Download/file_example_MP3_1MG.mp3";
  // String path = "/sdcard/Download/sample.mp3";

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (elapsedTime.inMilliseconds < maxDuration.inMilliseconds) {
        setState(() {
          elapsedTime += const Duration(milliseconds: 500);
        });
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

  @override
  Widget build(BuildContext context) {
    var avgSamples = AverageAlgorithm(samples: samples, maxSample: 150)
        .execute();
    return Scaffold(
      body: Center(
        child:  PulseWaveform(
            height: 50,
            width: MediaQuery.of(context).size.width,
            maxDuration: maxDuration,
            elapsedDuration: elapsedTime,
            activeColor: Colors.redAccent,
            borderWidth: 2,
            inactiveColor: Colors.black,
            showActiveWaveform: true,
            samples: avgSamples),
        // child: GeneralAudioWaveform(
        //   algorithm: ScalingType.average,
        //   maxDuration: maxDuration,
        //   elapsedDuration: Duration(milliseconds: 3000),
        //   elapsedIsChanged: (d){
        //     setState(() {
        //       elapsedTime = d;
        //     });
        //   },
        //   path: path,
        //   height: 100,
        //   width: MediaQuery.of(context).size.width * 0.5 ,maxSamples: 50,
        // ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
            // Flexible(
            //     child: IconButton(
            //         onPressed: _onAddPressed,
            //         icon: const Icon(Icons.add))),
            // Flexible(
            //     child: IconButton(
            //         onPressed: _onReplayPressed,
            //         icon: const Icon(Icons.replay))),
            // Stack(
            //   children: [
            //     PulseWaveform(
            //         height: 50,
            //         width: MediaQuery.of(context).size.width,
            //         maxDuration: maxDuration,
            //         elapsedDuration: elapsedTime,
            //         activeColor: Colors.redAccent,
            //         borderWidth: 2,
            //         inactiveColor: Colors.black,
            //         showActiveWaveform: true,
            //         samples: avgSamples),
            //     Theme(
            //       data: ThemeData(
            //           sliderTheme: SliderThemeData(
            //               thumbShape: SliderComponentShape.noOverlay,
            //               activeTrackColor: Colors.transparent,
            //               inactiveTrackColor: Colors.transparent),
            //           splashFactory: NoSplash.splashFactory,
            //           hoverColor: Colors.transparent,
            //           focusColor: Colors.transparent,
            //           splashColor: Colors.transparent,
            //           highlightColor: Colors.transparent),
            //       child: Slider(
            //         value: (elapsedTime.inMilliseconds).toDouble(),
            //         max: (maxDuration.inMilliseconds).toDouble(),
            //         divisions: maxDuration.inMilliseconds,
            //         onChanged: (double value) {
            //           setState(() {
            //             elapsedTime = Duration(milliseconds: value.round());
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
          // ],
        // ),
      ),
    );
  }

  void _onReplayPressed() {

    setState(() {
      elapsedTime = Duration.zero;
    });
  }

  void _onAddPressed() {
    requestPermissions();
    setState(() async {
      samples =  await Decoder(path: path).extract();
    });
  }
}
