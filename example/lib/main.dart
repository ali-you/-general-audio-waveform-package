
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';
import 'package:general_audio_waveforms/src/data/scaling/average_algorithm.dart';
import 'package:general_audio_waveforms/src/data/scaling/median_algorithm.dart';
import 'package:general_audio_waveforms/src/data/decoder/decoder.dart';
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
  List<double> samples =  [];
  // String path = "/storage/emulated/0/Download/file_example_MP3_700KB.mp3";
  // String path = "/storage/emulated/0/Download/file_example_OOG_1MB.ogg";
  String path = "/storage/emulated/0/Download/sample-1.m4a";

  @override
  void initState()  {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime += const Duration(seconds: 1);
      });
    });
    super.initState();
  }


  Future<void> requestPermissions() async {
    await [
      Permission.storage,
    ].request();
  }



  @override
  Widget build(BuildContext context) {
    var avgSamples = AverageAlgorithm(samples: samples,maxSample: 50).execute();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: IconButton(onPressed: _onPressed , icon: const Icon(Icons.add))),
            PulseWaveform(
              height: 50,
              width: MediaQuery.of(context).size.width ,
              maxDuration: const Duration(seconds: 2000),
              elapsedDuration: elapsedTime,
              activeColor: Colors.redAccent,
              borderWidth: 2,
              inactiveColor: Colors.black,
              samples: avgSamples
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    requestPermissions();
    var s = await Decoder(path:path).extract();
    setState(() {
      samples = s;
    });
  }
}
