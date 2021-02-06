import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/services/database.dart';

class MyGoogleMap extends StatefulWidget {
  final String chatRoomId;
  final String name;
  const MyGoogleMap(this.chatRoomId, this.name);
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String name1;
  bool _loading = false;
  String addressLocation;
  String country;
  String postalCode;
  var lat;
  var long;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  static double currentLatitude = 0.0;
  static double currentLongitude = 0.0;
  GoogleMapController myController;
  @override
  void initState() {
    lw();
    getMarkerData();
    name1 = widget.name;
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var cp = CameraPosition(
      target: LatLng(currentLatitude, currentLongitude),
      zoom: 19,
      tilt: 50,
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${widget.name}'s Location"),
      ),
      body: Stack(
        children: [
          _loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: GoogleMap(
                    // YOUR MARKS IN MAP,
                    padding: EdgeInsets.only(bottom: 0),
                    myLocationEnabled: true,
                    initialCameraPosition: cp,
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(markers.values),
                    onMapCreated: (GoogleMapController controller) {
                      myController = controller;
                    },
                  ),
                ),
          Container(
            alignment: Alignment.topCenter,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () => sendMessage(),
              child: Text(
                "Show My Address",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: RaisedButton(
              color: Colors.red,
              onPressed: () => getMarkerData(),
              child: Text(
                "Show ${widget.name} Address",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  lw() async {
    Position p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    lat = p.latitude;
    long = p.longitude;
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var firstAddress = addresses.first;
    Map<String, dynamic> messageMap = {
      'latitude': p.latitude,
      'longitude': p.longitude,
      'address': firstAddress.addressLine,
      'country': firstAddress.countryName,
      'postalcode': firstAddress.postalCode,
      'sender': Constants.myName,
      'time': DateTime.now().toString(),
    };
    await databaseMethods.addLocation(widget.chatRoomId, messageMap);
    setState(() {
      country = firstAddress.countryName;
      postalCode = firstAddress.postalCode;
      addressLocation = firstAddress.addressLine;
    });
  }

  sendMessage() {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "$addressLocation : $postalCode : $country",
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 10),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void initMarker(specify, specifyId) async {
    var markerIdval = specifyId;
    final MarkerId markerId = MarkerId(markerIdval);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['latitude'], specify['longitude']),
      infoWindow:
          InfoWindow(title: "${widget.name}", snippet: specify['address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    databaseMethods.getLocation(widget.chatRoomId).then((myMockData) {
      if (myMockData.documents.isNotEmpty) {
        for (var i = 0; i < myMockData.documents.length; i++) {
          if (myMockData.documents[i].data()["sender"] == widget.name) {
            initMarker(myMockData.documents[i].data(),
                myMockData.documents[i].documentID);
            setState(() {
              currentLatitude = myMockData.documents[i].data()["latitude"];
              currentLongitude = myMockData.documents[i].data()["longitude"];
            });
            myController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(myMockData.documents[i].data()["latitude"],
                        myMockData.documents[i].data()["longitude"]),
                    zoom: 17)));
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "${myMockData.documents[i].data()["address"]}",
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 10),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
        }
      }
    });
  }
}
