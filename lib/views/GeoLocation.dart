import 'package:copyongtoolkit/widgets/MainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocation extends StatefulWidget {
  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  double latitude;
  double longitude;
  String address;
  Position position;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;

      if (placemarks != null && placemarks.length > 0) {
        Placemark placemark = placemarks[0];
        address = placemark.name +
            " " + placemark.thoroughfare + " " +
            placemark.postalCode +
            " " +
            placemark.country;
      } else {
        address = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(title: Text('Geo Location'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(latitude!= null ? latitude.toString() : 'NA'),
              Text(latitude!= null ? longitude.toString() : 'NA'),
              Text(address != null ? address : 'NA'),
            ],
          ),
        ),
      ),
    );
  }
}
