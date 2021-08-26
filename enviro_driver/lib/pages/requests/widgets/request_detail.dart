import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RequestCardDetailModal extends StatelessWidget {
  final String? desc;
  final int plak;
  final String postalCode;
  final String time;
  final String address;
  final double lat;
  final double lng;
  final String imageUrl;

  final bool isSpecial;

  const RequestCardDetailModal({
    Key? key,
    this.desc,
    required this.time,
    required this.plak,
    required this.postalCode,
    required this.address,
    required this.lat,
    required this.lng,
    this.imageUrl = "",
    this.isSpecial = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // start Special request data
        if (isSpecial)
          const NERequestTitle(
            imagePath: "assets/building.png",
            title: "اطلاعات درخواست ویژه",
          ),
        if (isSpecial) const SizedBox(height: 4),
        if (isSpecial)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: lightBorder,
            ),
            child: Center(
              child: Text(
                desc ?? "توضیحاتی درج نشده است",
              ),
            ),
          ),
        if (isSpecial) const SizedBox(height: 4),
        if (isSpecial && imageUrl != "")
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
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const Center(),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        if (isSpecial) const SizedBox(height: 16),
        // end Special request data
        const NERequestTitle(
          imagePath: "assets/cal.png",
          title: "زمان دریافت",
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: lightBorder,
          ),
          child: Center(child: Text(time)),
        ),
        const SizedBox(height: 16),
        const NERequestTitle(
          imagePath: "assets/building.png",
          title: "مکان ساختمان",
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: lightBorder,
          ),
          child: Center(
            child: Text(address),
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
              Text("پلاک : $plak"),
              Text("کد پستی : $postalCode"),
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
                      lat: lat,
                      lng: lng,
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
                  latLng: LatLng(lat, lng),
                  radius: 0,
                ),
              ),
            ),
          ),
        ),
        // end loaction request data
        const SizedBox(height: 16),

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
