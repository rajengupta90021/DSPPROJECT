import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindYouCenter extends StatefulWidget {
  const FindYouCenter({super.key});

  @override
  State<FindYouCenter> createState() => _FindYouCenterState();
}

class _FindYouCenterState extends State<FindYouCenter> {
  List<Map<String, dynamic>> _locations = [];
  bool _isLoading = true;
  String _coordinates1 = 'N/A';
  String _coordinates2 = 'N/A';
  String _address = 'No Address Found';

  @override
  void initState() {
    super.initState();
    _fetchAndStoreLocation();
    _loadJsonData();
  }

  Future<void> _fetchAndStoreLocation() async {
    setState(() {
      _isLoading = true;
    });

    // Check for location permission
    LocationPermission permission = await Geolocator.checkPermission();

    // If permission is denied, request it
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
          _address = "Location permissions are denied";
        });
        return;
      }
    }

    // If permission is permanently denied, show message and stop fetching location
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
        _address = "Location permissions are permanently denied. Enable from settings.";
      });
      return;
    }

    // If permissions are granted, get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double lon = position.longitude;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('latitude', lat.toString());
      await prefs.setString('longitude', lon.toString());

      setState(() {
        _coordinates1 = lat.toString();
        _coordinates2 = lon.toString();
        _address = "Current Location"; // You can add reverse geocoding here to fetch the address
      });
    } catch (e) {
      // Handle any errors like network or GPS issues
      setState(() {
        _address = "Error fetching location: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _loadJsonData() async {
    final String response = await rootBundle.loadString('assets/Location.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _locations = data.cast<Map<String, dynamic>>();
    });
  }

  Future<double> _calculateDistance(double lat1, double lon1, double lat2, double lon2) async {
    final double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters / 1000; // Convert to kilometers
  }

  Widget _buildLabCard(Map<String, dynamic> location, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10), // Add margin for spacing
      padding: const EdgeInsets.all(16.0), // Add padding for content
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
        borderRadius: BorderRadius.circular(8), // Rounded corners
        border: Border.all(color: Colors.grey.withOpacity(0.5)), // Add a border for slight separation
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Name with Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align vertically center
            children: [
              Image.asset(
                'assets/logo.jpg',
                width: 25,
                height: 25, // Set desired image height
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  location['Name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Row for Address with Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align vertically center
            children: [
              Image.asset(
                'assets/homelocation.png',
                width: 25,
                height: 25,
              ),
              SizedBox(width: 10), // Add space between image and text
              Expanded(
                child: Text(
                  location['Address'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Truncate text if it’s too long
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Row for Pincode with Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align vertically center
            children: [
              Image.asset(
                'assets/pincode.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Pincode: ${location['Area Pincode']}'),
            ],
          ),
          SizedBox(height: 8),

          // Row for Distance with Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/distance.png',
                width: 25,
                height: 25,
              ),
              SizedBox(width: 10),
              _coordinates1 == 'N/A' || _coordinates2 == 'N/A'
                  ? Text('Distance: Not available')
                  : FutureBuilder<double>(
                future: _calculateDistance(
                    double.tryParse(_coordinates1) ?? 0, double.tryParse(_coordinates2) ?? 0,
                    location['Latitude'], location['Longitude']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Calculating distance...');
                  } else if (snapshot.hasError) {
                    return Text('Error calculating distance');
                  } else {
                    return Text('Distance: ${snapshot.data?.toStringAsFixed(2)} km');
                  }
                },
              ),
            ],
          ),

          SizedBox(height: 8),

          // Row for Phone Numbers with Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Align vertically center
            children: [
              Image.asset(
                'assets/telephone2.png',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 10),
              Text(
                '${location['Mobile1']}  /  ${location['Mobile2']}', // No space between numbers, with a slash separating them
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make both numbers bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Lab',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: iconcolor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final location = _locations[index];
          return _buildLabCard(location, index);
        },
      ),
    );
  }
}
