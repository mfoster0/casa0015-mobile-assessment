import 'package:calmer_beats/widgets/activity_widget.dart';
import 'package:flutter/material.dart';
import 'package:calmer_beats/widgets/app_state.dart';
import 'package:provider/provider.dart';
import 'package:calmer_beats/widgets/video_widget.dart';


class SightScreen extends StatefulWidget {


  String activity = "";
  final String activityName;
  final int duration;

  SightScreen({super.key, required this.activityName, required this.duration} ) ;

  @override
  _SightScreenState createState() => _SightScreenState();
}

class _SightScreenState extends State<SightScreen> {



  @override
  Widget build(BuildContext context) {
    final activityName = widget.activityName;
    final duration = widget.duration;

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Activity Screen'),
        backgroundColor: Colors.blueAccent,
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400, // Specify your desired width
              height: 260,
              child: VideoPlayerWidget(),
            ),
            Text(
              'Activity: $activityName, Durationqqq: $duration',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null ,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}


