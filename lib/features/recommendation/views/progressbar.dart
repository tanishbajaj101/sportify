import 'package:flutter/material.dart';

class LinearProgressIndicatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }

  const LinearProgressIndicatorApp({super.key});
}

class LinearProgressIndicatorAppState
    extends State<LinearProgressIndicatorApp> {
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Linear Progress Bar"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: _loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.red),
                      value: _progressValue,
                    ),
                    Text('${(_progressValue * 100).round()}%'),
                  ],
                )
              : const Text("Press button for downloading",
                  style: TextStyle(fontSize: 25)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // if textfield empty or option not selected then route to next page, else showSnackbar
            _loading = true;
            _progressValue += 0.25;

            if (_progressValue >= 1.00) {
              _loading = false;
              return;
            }
          });
        },
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}
