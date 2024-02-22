import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prosummary', // Update your app's title
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Customize theme if desired
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denial - Inform the user
      return;
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recorder.stop();
      setState(() => _isRecording = false);
    } else {
      await _recorder.start(path: '/Users/thomasmac/Documents/Prosummary App/recording.m4a');
      setState(() => _isRecording = true);
    }
  }

  // Build the rest of your MainPage widget's UI here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prosummary"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Adjust alignment if needed
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _toggleRecording,
              child: Text(_isRecording ? 'STOP' : 'RECORD'),  // Adapt button styling
            ),
          ),
          // ... Other widgets for your page's UI
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());
