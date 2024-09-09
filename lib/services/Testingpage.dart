import 'package:dspuiproject/widgets/LoadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final Color myColor = Color.fromRGBO(128, 178, 247, 1);
  bool _isLoading = true;
  String _coordinates1 = '';
  String _coordinates2 = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    // Simulate a delay to show loading overlay
    await Future.delayed(Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _coordinates1 = prefs.getString('latitude') ?? 'N/A';
      _coordinates2 = prefs.getString('longitude') ?? 'N/A';
      _address = prefs.getString('address') ?? 'No Address Found';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure Column does not take up more space than needed
              children: [
                Text('Latitude:'),
                Text(_coordinates1, textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text('Longitude:'),
                Text(_coordinates2, textAlign: TextAlign.center),
                SizedBox(height: 20),
                Text('Address:'),
                Text(_address, textAlign: TextAlign.center),
              ],
            ),
          ),
          LoadingOverlay(isLoading: _isLoading),
        ],
      ),
    );
  }
}


