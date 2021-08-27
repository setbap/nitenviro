import 'package:enviro_shared/enviro_shared.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HistoryDetail extends StatelessWidget {
  final SpacialRequest spacialRequest;
  const HistoryDetail({
    Key? key,
    required this.spacialRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const NERequestTitle(
          title: "توضیحات راننده",
        ),
        const SizedBox(
          height: 4,
        ),
        DetailItemBox(
          child: Text(
            spacialRequest.driverDescription ?? "توضیحاتی درج نشده است",
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (spacialRequest.imageUrl != null)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 1.618,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [blueGradient, greenGradient],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: spacialRequest.imageUrl ?? "",
                  placeholder: (context, url) => const Center(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
        const NERequestTitle(
          title: "زمان دریافت",
        ),
        const SizedBox(height: 6),
        DetailItemBox(
          child: Center(
              child: Text(
                  "${spacialRequest.receivedTime!.toPersianDateStr(showDayStr: true)}  ${spacialRequest.receivedTime!.hour}:${spacialRequest.receivedTime!.minute}")),
        ),
        const SizedBox(height: 16),
        const NERequestTitle(
          title: "وزن محصولات دریافتی",
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          child: Center(
            child: Text("شیشه  :  ${spacialRequest.glassWeight} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("فلر  :  ${spacialRequest.metalWeight} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("پلاستیک  :  ${spacialRequest.plasticWeight} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("کاغذ  :  ${spacialRequest.paperWeight} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusBottom: 16,
          radiusTop: 0,
          child: Center(
            child: Text("مخلوط  :  ${spacialRequest.mixedWeight} kg"),
          ),
        ),
        const SizedBox(height: 16),
        const NERequestTitle(
          title: "مکان ساختمان",
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          child: Center(
            child: Text(spacialRequest.building.address),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: lightBorder,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("پلاک : ${spacialRequest.building.plaque}"),
              Text("کد پستی : ${spacialRequest.building.postalCode}"),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                HeroLocationRoute(
                  builder: (context, animation) {
                    return BluredSimpleMap(
                      lat: spacialRequest.building.latitude,
                      lng: spacialRequest.building.longitude,
                    );
                  },
                ),
              );
            },
            child: AbsorbPointer(
              child: Hero(
                tag: "main_simple_map_hero",
                child: SimpleLocation(
                  key: const ValueKey("locationKey"),
                  latLng: LatLng(spacialRequest.building.latitude,
                      spacialRequest.building.longitude),
                  radius: 0,
                ),
              ),
            ),
          ),
        ),
        // end loaction request data
        const SizedBox(height: 16),
        // start Special request data

        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: darkGreen.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: darkGreen,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "بازگشت",
              style: TextStyle(
                fontSize: 20,
                color: darkGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class DetailItemBox extends StatelessWidget {
  final Widget child;
  final double radiusTop;
  final double radiusBottom;
  const DetailItemBox({
    Key? key,
    this.radiusBottom = 0,
    this.radiusTop = 16,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusTop),
          bottom: Radius.circular(radiusBottom),
        ),
        color: lightBorder,
      ),
      child: child,
    );
  }
}
