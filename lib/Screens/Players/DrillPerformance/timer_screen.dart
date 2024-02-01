import 'package:flutter/material.dart';
import 'dart:async';
import 'package:basketball_coaching/Screens/Players/DrillPerformance1/drill_performance1.dart';

class TimerScreen extends StatefulWidget {
  final int initialMinutes;
  final int initialSeconds;
  final String drillName;

  TimerScreen(
      {required this.initialMinutes,
      required this.initialSeconds,
      required this.drillName});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int minutes;
  late int seconds;
  late int totalTimeInSeconds;
  late int currentTimeInSeconds;
  bool isRunning = false;
  int coveredMinutes = 0;
  int coveredSeconds = 0;

  @override
  void initState() {
    super.initState();
    minutes = widget.initialMinutes;
    seconds = widget.initialSeconds;
    totalTimeInSeconds = minutes * 60 + seconds;
    currentTimeInSeconds = totalTimeInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(currentTimeInSeconds ~/ 60).toString().padLeft(2, '0')}:${(currentTimeInSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startTimer,
              child: Text('Start Timer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? endTimer : null,
              child: Text('End Timer'),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTimeInSeconds > 0) {
        setState(() {
          currentTimeInSeconds--;
        });
      } else {
        timer.cancel();
        onTimerEnd();
      }
    });
  }

  void endTimer() {
    coveredMinutes = minutes - (currentTimeInSeconds ~/ 60);
    coveredSeconds = seconds - (currentTimeInSeconds % 60);

    if (currentTimeInSeconds == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DrillPerformance1(
            drillName: widget.drillName,
            coveredMinutes: coveredMinutes,
            coveredSeconds: coveredSeconds,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DrillPerformance1(
            drillName: widget.drillName,
            coveredMinutes: minutes,
            coveredSeconds: seconds,
          ),
        ),
      );
    }
  }

  void onTimerEnd() {
    setState(() {
      isRunning = false;
    });
    endTimer();
  }
}
