import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:nitenviro/utils/utils.dart';

typedef OneItemCallBack = void Function(LatLng latLng);

class ShowMap extends StatefulWidget {
  final OneItemCallBack oneItemCallBack;
  final LatLng? latLng;

  const ShowMap({
    Key? key,
    required this.oneItemCallBack,
    this.latLng,
  }) : super(key: key);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late final LatLng latLng;
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double> _centerCurrentLocationStreamController;
  final MapController _controller = MapController();

  @override
  void initState() {
    super.initState();
    latLng = widget.latLng ?? LatLng(36.56, 52.68);
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
    _centerCurrentLocationStreamController = StreamController<double>();
  }

  @override
  void dispose() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowDarken,
        actions: [
          TextButton(
              onPressed: () {
                widget.oneItemCallBack(_controller.center);
                Navigator.pop(context);
              },
              child: Text(
                "ثبت موقعیت",
                style: textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        title: Text(
          "مشخص کردن موقعیت خانه",
          style: textTheme.subtitle1!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              center: latLng,
              zoom: 13,
              maxZoom: 19,
              // Stop centering the location marker on the map if user interacted with the map.
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  setState(
                    () =>
                        _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  );
                }
              },
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  maxZoom: 19,
                ),
              ),
              LocationMarkerLayerWidget(
                plugin: LocationMarkerPlugin(
                  centerCurrentLocationStream:
                      _centerCurrentLocationStreamController.stream,
                  centerAnimationDuration: const Duration(milliseconds: 700),
                  centerOnLocationUpdate: _centerOnLocationUpdate,
                ),
              ),
            ],
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 48, left: 0),
              child: Icon(
                Icons.location_on_outlined,
                size: 48,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 32.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(
              message: "راهنما انتخاب ساختمان",
              child: FloatingActionButton.extended(
                heroTag: "twoPunchMan",
                foregroundColor: Colors.white,
                onPressed: () {
                  showModal(
                    context: context,
                    builder: (BuildContext context) {
                      return _ExampleAlertDialog();
                    },
                  );
                },
                icon: const Icon(Icons.help_outline),
                label: const Tooltip(
                  message: "راهنما انتخاب ساختمان",
                  child: Text("راهنما"),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: "onePunchMan",
              onPressed: () {
                // Automatically center the location marker on the map when location updated until user interact with the map.
                setState(
                  () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
                );
                // Center the location marker on the map and zoom the map to level 18.
                _centerCurrentLocationStreamController.add(18);
              },
              child: const Tooltip(
                message: "نمایش موقعیت فعلی من",
                child: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExampleAlertDialog extends StatelessWidget {
  final helpSteps = const <String>[
    "\u2022  تقشه را طوری جابجا کنید که مکان نما وسط صحفه در موقعیت شما قرار بگیرد",
    "\u2022  در صورتی که میخواد موقعیت فعلی خود را انتخاب کنید ایکون موقعیت من در پایین سمت چپ را انتخاب کنید",
    "\u2022  در صورت تایید دسترسی به موقعیت شما مکان حدودی شما نمایش داده میشود",
    "\u2022  میتوانید با جابجایی موقعیت دقیق خود را مشخص کنید",
    "\u2022  دقت داشته باشید ایکون نارنجی محل انتخاب شمایس نه موقعیت فعلی",
    "\u2022  پس از مشخص شدن مکان دکمه تایید در بالا صفحه را فشار دهید"
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("راهنما انتخاب موقعیت فعلی"),
      content: SizedBox(
        height: 400,
        child: Column(
          children: helpSteps
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(e),
                ),
              )
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('متوجه شدم'),
        ),
      ],
    );
  }
}
