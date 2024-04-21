import 'package:calmer_beats/widgets/activity_widget.dart';
import 'package:flutter/material.dart';
import 'package:calmer_beats/widgets/app_state.dart';
import 'package:provider/provider.dart';

class ObserveScreen extends StatefulWidget {


  String activity = "";
  final String activityName;
  final int duration;

  ObserveScreen({super.key, required this.activityName, required this.duration} ) ;

  @override
  _ObserveScreenState createState() => _ObserveScreenState();
}

class _ObserveScreenState extends State<ObserveScreen> {
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
            Text(
              'Activity: $activityName, Durationxxxx: $duration',
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
