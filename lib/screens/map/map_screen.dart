import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/NavigatorKey.dart';
import 'package:shop_app/helper/backendHelper/SQLHelper.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class MapScreen extends StatefulWidget {
  static String routeName = "/map";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Your Address'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onTap: (latLng) async {
// From coordinates
            final coordinates =
                new Coordinates(latLng.latitude, latLng.longitude);
            var addresses =
                await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            print("${first.featureName} : ${first.addressLine}");
            Provider.of<CartProvider>(context, listen: false)
                .setAddress(first.addressLine);

            bool boo = await FireStoreHelper.fireStoreHelper.addOrder(context);

            if (boo) {
              Provider.of<CartProvider>(context,listen: false).clearAll();
              SQLHelper.helper.deleteAll();
              Fluttertoast.showToast(
                  msg: "Data added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fontSize: 16.0);

              NavigationService.navigationService
                  .navigateTo(HomeScreen.routeName);
            }else {
              Fluttertoast.showToast(
                  msg: "Error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
