import 'dart:async';
import 'package:flutter/material.dart';

class ShotClockWidget extends StatefulWidget {
  final int initialTime; // Initial shot clock time (e.g., 24 seconds)

  ShotClockWidget({this.initialTime = 24});

  @override
  _ShotClockWidgetState createState() => _ShotClockWidgetState();
}

class _ShotClockWidgetState extends State<ShotClockWidget> {
  late int timeRemaining;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    timeRemaining = widget.initialTime; // Set the initial shot clock time
  }

  void toggleClock() {
    if (isRunning) {
      // Pause the clock
      if (timer != null) timer!.cancel();
      setState(() {
        isRunning = false;
      });
    } else {
      // Start the clock
      setState(() {
        isRunning = true;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (timeRemaining > 0) {
            timeRemaining--;
          } else {
            timer.cancel();
            isRunning = false; // Stop the clock when it reaches 0
          }
        });
      });
    }
  }

  void resetClock() {
    if (timer != null) timer!.cancel();
    setState(() {
      timeRemaining = widget.initialTime;
      isRunning = false;
    });
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth * 0.015;
    double responsiveFontClockSize = screenWidth * 0.040;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Shot Clock Label
        Text(
          'Shot Clock',
          style: TextStyle(
            fontSize: responsiveFontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'Digital',
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        // Shot clock display (Clickable)
        GestureDetector(
          onTap: toggleClock, // Play or pause when clicked
          child: Text(
            timeRemaining.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: responsiveFontClockSize,
              fontFamily: 'Digital', // Use your preferred font
              color: isRunning ? Colors.green : Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Reset Button
        ElevatedButton(
          onPressed: resetClock,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child:const Text('Reset'),
        ),
      ],
    );
  }
}