import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RequestCardDetailModal extends StatelessWidget {
  final String desc;
  final int plak;
  final String postalCode;
  final int time;
  final String address;
  final double lat;
  final double lng;
  final String imageUrl;
  final String specialDesc;
  final bool isSpecial;

  const RequestCardDetailModal({
    Key? key,
    required this.desc,
    required this.time,
    required this.plak,
    required this.postalCode,
    required this.address,
    required this.lat,
    required this.lng,
    this.imageUrl = "",
    this.specialDesc = "",
  })  : isSpecial = imageUrl != "" || specialDesc != "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const NERequestTitle(
          imagePath: "assets/alert.png",
          title: "توضیحات",
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            color: lightBorder,
          ),
          child: Text(desc),
        ),
        const SizedBox(height: 16),
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
          child: Center(child: Text(timeOfDayDataTuple[time].item1)),
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
                specialDesc.isNotEmpty ? specialDesc : "توضیحاتی درج نشده است",
              ),
            ),
          ),
        if (isSpecial) const SizedBox(height: 4),
        if (isSpecial && imageUrl != "")
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: AbsorbPointer(
              child: Hero(
                tag: "main_simple_image_hero",
                child: Image.network(
                  imageUrl,
                ),
              ),
            ),
          ),
        if (isSpecial) const SizedBox(height: 16),
        // end Special request data
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
