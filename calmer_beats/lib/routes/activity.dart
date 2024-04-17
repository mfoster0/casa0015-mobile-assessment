import 'package:flutter/material.dart';
import 'package:calmer_beats/widgets/app_state.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {


  String activity = "";
  final String activityName;
  final int duration;

  ActivityScreen({super.key, required this.activityName, required this.duration} ) ;

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final activityName = widget.activityName;
    final duration = widget.duration;

    print("_ActivityScreenState.activityName: $activityName");
    print("_ActivityScreenState.duration: $duration");

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Activity Screen'),
        backgroundColor: Colors.blueAccent,
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Activity: $activityName, Duration: $duration',
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
