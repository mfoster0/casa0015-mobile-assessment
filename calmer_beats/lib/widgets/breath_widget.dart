//using examples from:
// https://pub.dev/packages/vibration
// https://api.flutter.dev/flutter/animation/TweenSequence-class.html
// https://www.sandromaglione.com/articles/how-to-use-tween-learn-all-about-flutter-animations-part-2

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';



class BreathBall extends StatefulWidget {
  final int duration;

  BreathBall({super.key, required this.duration} ) ;
  @override
  _BreathBallState createState() => _BreathBallState();
}

class _BreathBallState extends State<BreathBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _text = '...'; // Initial text
  String _buttonText = 'Start';
  late int exerciseDuration;

  @override
  void initState() {
    super.initState();
    exerciseDuration = widget.duration;
    //config for timings and sizes
    int totalTime = 13; //total time in secs
    Map<String, double> phases = {
      'sMax': 200, //sizes
      'sMin': 20,
      'wGrow': 2, //weight - proportion of total time
      'wGrowSlow': 1,
      'wShrink': 5,
      'wShrinkSlow': 1,
      'wPause': 2,
      'minPerc': 0.2,
      'maxPerc': 0.9,
    };

    _controller = AnimationController(
      duration: Duration(seconds: totalTime), // Total duration for all phases
      vsync: this,
    );

    //create an expanding circle that is used to connect with the user
    //illustrating when they should breathe in and out
    _animation = TweenSequence<double>([
      //expand
      TweenSequenceItem(
        //increase size
        tween: Tween<double>(
            begin: phases['sMin'],
            end: phases['sMax']! *
                phases['maxPerc']!), // increase to n% of full size
        weight: 3, // Duration weight for growth phase
      ),
      //slowing increase
      TweenSequenceItem(
        tween: Tween<double>(
            begin: phases['sMax']! * phases['maxPerc']!,
            end: phases['sMax']), // Slow increase at n% to full size
        weight: 1, // Duration weight for growth phase
      ),
      //pause
      TweenSequenceItem(
        tween: Tween<double>(
            begin: phases['sMax'], end: phases['sMax']), //hold at full size
        weight: 2, // Duration weight for reduction phase
      ),
      //reduce size
      TweenSequenceItem(
        tween: Tween<double>(
            begin: phases['sMax'],
            end: phases['sMin']! +
                ((phases['sMax']! - phases['sMin']!) *
                    phases['minPerc']!)), //slow for last n%
        weight: 7, // Duration weight for reduction phase
      ),
      //slow final reduction
      TweenSequenceItem(
        tween: Tween<double>(
            begin: phases['sMin']! +
                ((phases['sMax']! - phases['sMin']!) *
                    phases['minPerc']!), //slow for n%
            end: phases['sMin']), // Adjust begin for full height
        weight: 2, // Duration weight for reduction phase
      ),
      //pause
      TweenSequenceItem(
        tween: Tween<double>(
            begin: phases['sMin'], end: phases['sMin']), //hold at min size
        weight: 1, // Duration weight for reduction phase
      ),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {
          // Example logic to update text based on animation value
          if (_animation.value <= phases['sMin']! * 1.1) {
            _text = 'Pause';

          } else if (_animation.value >= phases['sMax']! * 0.9) {
            _text = 'Hold In';
          } else if (_text == 'Hold In' &&
              _animation.value < phases['sMax']! * 0.9) {
            _text = 'Breathe Out';
            Vibration.vibrate(duration:750);

          } else if (_text == 'Pause' &&
              _animation.value > phases['sMin']! * 1.1) {
            _text = 'Breathe In';
            Vibration.vibrate(duration:200);
          }
        });
      });
  }

  void vibeNow (){
    Vibration.vibrate(duration: 500);
  }
  void startAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }

    //use the value passed from the previous route
    // stop the animation after n seconds
    Future.delayed(Duration(minutes: exerciseDuration), () {
      if (_controller.isAnimating) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.05, // Button at n% of screen height
          left: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () {
              startAnimation();
              setState(() {
                _buttonText = _buttonText == "Start" ? "Stop" : "Start";
              });
              Future.delayed(Duration(minutes: exerciseDuration), () {
                Navigator.pop(context);
              });
            },
            child: Text(_buttonText,
                style: TextStyle(
                  fontSize: 24,
                )),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.65),
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.30 -
              (_animation.value / 2),
          left: MediaQuery.of(context).size.width / 2 - (_animation.value / 2),
          child: Container(
            width: _animation
                .value, // Use animation value for width to simulate sphere growth
            height: _animation
                .value, // Use animation value for height to simulate sphere growth
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Keep the circular shape
              gradient: RadialGradient(
                colors: [
                  Colors.orange
                      .shade200, // Lighter color on one side to simulate light
                  Colors.orange
                      .shade900, // Darker color on the opposite side to simulate shadow
                ],
                stops: [
                  0.3,
                  1.0
                ], // Adjust these stops to control the gradient effect
                focal: Alignment(-0.2,
                    -0.2), // Shift the focal point to enhance the 3D effect
                focalRadius: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
