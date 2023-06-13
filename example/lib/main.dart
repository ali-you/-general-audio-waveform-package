import 'dart:async';

import 'package:flutter/material.dart';
import 'package:general_audio_waveforms/src/waveforms/pulse_waveform/pulse_waveform.dart';

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
  Duration elspadeTime = const Duration(seconds: 0);

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // elspadeTime += const Duration(seconds: 1);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: PulseWaveform(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.43 ,
          maxDuration: const Duration(seconds: 100),
          elapsedDuration: elspadeTime,
          activeColor: Colors.redAccent,
          borderWidth: 3,
          inactiveColor: Colors.black,
          samples: const [-0.062317353988907675,

            -0.4598192859194377,
            -0.17790674342532247,
            -0.2737327368615886,
            -0.8037565711962959,
            -0.3403352437735105,
            -0.3403352437735105,
            -0.27446501118809963,
            -0.4301010490359812,
            -0.9557947637174682,
            -0.7229677525107734,
            -0.7902207265972939,
            -0.31003540156953254,
            -0.47350054498637754,
            -0.47350054498637754,
            -0.3664684001886169,
            -0.27446501118809963,
            -0.4301010490359812,
            -0.9557947637174682,
            -0.7229677525107734,
            -0.7902207265972939,
            -0.31003540156953254,
            -0.47350054498637754,
            -0.47350054498637754,
            -0.3664684001886169,
            -0.1646064842178242,
            -0.5152226261639911,
            -0.0877756528089301,
            -0.31003540156953254,
            -0.47350054498637754,
            -0.3664684001886169,
            -0.1646064842178242,
            -0.5152226261639911,
            -0.0877756528089301,
            -0.4180132621450826,
            -0.7140882743237471,
            -0.4598192859194377,
            -0.17790674342532247,
            -0.2737327368615886,
            -0.8037565711962959,
            -0.3403352437735105,
            -0.27446501118809963,
          ]
        ),
      ),
    );
  }
}
