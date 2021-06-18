import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/logic/location/location_request_cubit.dart';
import 'package:nitenviro/models/location_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:nitenviro/pages/add_building/show_map.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  MapController _mapController = MapController();
  LatLng latLng = LatLng(51.5, -0.09);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationRequestCubit, GenericApiState<LocationModel>>(
      listener: (context, state) {
        if (state.data != null) {
          latLng = LatLng(state.data!.latitude!, state.data!.longitude!);
          _mapController.move(latLng, 13);

          setState(() {});
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<LocationRequestCubit>()
                            .getCurrentLocation();
                      },
                      child: Text(
                        "get location",
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ShowMap(
                                oneItemCallBack: (latLng) {
                                  debugPrint(latLng.toString());
                                },
                              );
                            },
                          ));
                        },
                        child: Text("show map")),
                  ),
                ],
              ),
            ),
            Text("error : ${state.isError}"),
            Text("error : ${state.error}"),
            Text("is loading :  ${state.isLoading}"),
            Text("is loading : ${state.data.toString()}"),
            // Container(
            //   height: 300,
            //   child: FlutterMap(
            //     options: new MapOptions(
            //       center: latLng,
            //       zoom: 13.0,
            //     ),
            //     layers: [
            //       new TileLayerOptions(
            //           urlTemplate:
            //               "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            //           subdomains: ['a', 'b', 'c']),
            //       // new MarkerLayerOptions(
            //       //   markers: [
            //       //     new Marker(
            //       //       width: 80.0,
            //       //       height: 80.0,
            //       //       point: new LatLng(51.5, -0.09),
            //       //       builder: (ctx) =>
            //       //       new Container(
            //       //         child: new FlutterLogo(),
            //       //       ),
            //       //     ),
            //       //   ],
            //       // ),
            //     ],
            //     children: [
            //       LocationMarkerLayerWidget(),
            //     ],
            //   ),
            // )
          ],
        );
      },
    );
  }
}
