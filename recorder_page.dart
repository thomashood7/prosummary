import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderPage extends StatefulWidget {
  @override
  _RecorderPageState createState() => _RecorderPageState();
}

class _RecorderPageState extends State<RecorderPage> {
  final _recorder = Record();
  bool _isRecording = false;

  @override
  void dispose() {
    _recorder.dispose(); // Always release resources
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    final hasPermission = await Permission.microphone.request().isGranted;
    if (!hasPermission) {
      print('Microphone permission denied');
      return;
    }

    if (_isRecording) {
      final path = await _recorder.stop();
      print("Recording stopped. File saved at: $path");
    } else {
      await _recorder.start(path: '/your/desired/path.m4a');
      print('Recording started...');
    }

    setState(() => _isRecording = !_isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () => _toggleRecording(),
        label: Text(_isRecording ? 'STOP' : 'TAP TO RECORD'),
        icon: Icon(Icons.mic),
      ),
    );
  }
}
