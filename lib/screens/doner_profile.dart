// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DonerProfilePage extends StatefulWidget {
  final String documentId;
  const DonerProfilePage({super.key, required this.documentId});

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

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  var name;
  var pic;
  var loc;
  var blood;
  var num;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          name = data['fullname'];
          blood = data['bloodType'];
          loc = data['location'];
          pic = data['photoURL'];
          num = data['phonenumber'];
          //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        //return Text("loading");
        return Scaffold(
            appBar: AppBar(
        title: const Text("Profile"),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.navigate_before_rounded),
          //   tooltip: 'Back Icon',
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ), //IconButton
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   tooltip: 'Setting Icon',
          //   onPressed: () {},
          // ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.pinkAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.navigate_before_rounded),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
            body: Container(
              child: new ListView(children: [
                Center(
                  child: Image.network(
                    pic,
                    width: 80,
                    height: 60,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '                ${name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
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
                      Text("${loc}"),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                " ${blood}",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 233, 10, 103)),
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
      },
    );
  }
}
