// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ug_blood_donate/models/user_model.dart';

class DonerProfilePage extends StatefulWidget {
  const DonerProfilePage({super.key});

  @override
  State<DonerProfilePage> createState() => _DonerProfilePageState();
}

class _DonerProfilePageState extends State<DonerProfilePage> {
  MapType _currentMapType = MapType.normal;
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(0.3272399, 32.57796);
  static const LatLng destination = LatLng(0.312222, 32.585556);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel(groups: []);
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      //print('hi user');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.navigate_before_sharp,
            color: Colors.black,
            size: 24.0,
          ),
          title: const Text("Find Donors"),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: new ListView(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Card(
                      child: Image.asset(
                        'lib/images/ntanda.jpg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${loggedInUser.fullname}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
                /*3*/
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.pink),
                  Text("${loggedInUser.location}")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: <Widget>[
                    Center(
                      child: new Image.asset(
                        'assets/images/iconsase.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "6",
                          style: new TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          " Times donated",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: <Widget>[
                    new Positioned(
                        child: new Image.asset(
                      'assets/images/icon.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.fitWidth,
                    )),
                    Positioned(
                        child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "Blood Type",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${loggedInUser.bloodType}",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.contact_phone,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text('Call Now'),
                              onPressed: () {
                                print('Pressed');
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(150, 27, 158, 163)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.navigate_before_sharp,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              label: const Text('Request'),
                              onPressed: () {
                                print('Pressed');
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 233, 10, 103)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
            new Container(
              height: 350,
              width: 200,
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    compassEnabled: true,
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                        tilt: 9.0,
                        target: LatLng(0.339535, 32.571199),
                        zoom: 10.5),
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        position: LatLng(0.339535, 32.571199),
                      ),
                    },
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
