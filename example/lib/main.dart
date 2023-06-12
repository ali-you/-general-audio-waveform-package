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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
          child: PulseWaveform(
            height: 200,
            width: MediaQuery.of(context).size.width,
            samples: const [-0.062317353988907675,
            -0.3391800248037288,
            -0.7648498309823369,
            -0.1961320370661736,
            -0.9473968418329906,
            -0.8867653404267566,
            -0.06636911615594705,
            -0.7267796840771492,
            -0.8615370754719579,
            -0.8701555468917329,
            -0.7034178167606738,
            -0.4364026902128346,
            -0.1662775819874257,
            -0.8858132202525285,
            -0.4410404080899426,
            -0.7323441947337927,
            -0.9306201965567367,
            -0.6056109148981072,
            -0.6296391266894051,
            -0.4283517373813305,
            -0.01024897128260065,
            -0.5581862884800451,
            -0.05741456260214786,
            -0.6361900013408432,
            -0.9061185037647975,
            -0.34381495376237405,
            -0.2322516630206552,
            -0.08552433026891214,
            -0.09302496849178713,
            -0.5927483050058686,
            -0.12223367901934581,
            -0.19782812263841564,
            -0.784936494054503,
            -0.13844780611975152,
            -0.44867934573823867,
            -0.9231958875327948,
            -0.39824886840613713,
            -0.9495347002478112,
            -0.3282150942857559,
            -0.8731096621046853,
            -0.26808403657508655,
            -0.2302328627321475,
            -0.46664761116354717,
            -0.6927989362419835,
            -0.3412349276432469,
            -0.2844936890886802,
            -0.5382204753284094,
            -0.7712229626574783,
            -0.8236665580995195,
            -0.8156958206792818,
            -0.27243899538595034,
            -0.9795342531001742,
            -0.3089088439679097,
            -0.5573986211740384,
            -0.06835908231606477,
            -0.04795286918442476,
            -0.3251379380075853,
            -0.2277176341551021,
            -0.19341311158063814,
            -0.8674498286546517,
            -0.4320986397110915,
            -0.8725617587905426,
            -0.3474123087911027,
            -0.6216212460457866,
            -0.6387517022115385,
            -0.4235264058629497,
            -0.9144300340411697,
            -0.9134060530173227,
            -0.9084964587735682,
            -0.7540748478549064,
            -0.12327556048209791,
            -0.7188230474924466,
            -0.1950344916406936,
            -0.10266334261662443,
            -0.4180132621450826,
            -0.7140882743237471,
            -0.4598192859194377,
            -0.17790674342532247,
            -0.2737327368615886,
            -0.8037565711962959,
            -0.3403352437735105,
            -0.27446501118809963,
            -0.4301010490359812,
            -0.9557947637174682,
            -0.7229677525107734,
            -0.7902207265972939,
            -0.31003540156953254,
            -0.47350054498637754,
            -0.3664684001886169,
            -0.1646064842178242,
            -0.5152226261639911,
            -0.0877756528089301],
          ),
        ),
      ),
    );
  }
}
