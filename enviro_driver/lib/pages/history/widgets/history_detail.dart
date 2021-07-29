import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:enviro_driver/models/collected_rubbish.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HistoryDetail extends StatelessWidget {
  final CollectedRubish rubish;
  const HistoryDetail({
    Key? key,
    required this.rubish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const NERequestTitle(
          title: "توضیحات",
        ),
        const SizedBox(
          height: 4,
        ),
        DetailItemBox(
          child: Text(rubish.driverDesc),
        ),
        const SizedBox(
          height: 4,
        ),
        if (rubish.imageUrl.isNotEmpty)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: AbsorbPointer(
              child: Hero(
                tag: "main_simple_image_hero",
                child: Image.network(
                  rubish.imageUrl,
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
                  "${rubish.collectedAt.toPersianDateStr(showDayStr: true)}  ${rubish.collectedAt.hour}:${rubish.collectedAt.minute}")),
        ),
        const SizedBox(height: 16),
        const NERequestTitle(
          title: "وزن محصولات دریافتی",
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          child: Center(
            child: Text("شیشه  :  ${rubish.glass ?? 0} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("فلر  :  ${rubish.metal ?? 0} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("پلاستیک  :  ${rubish.plastic ?? 0} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusTop: 0,
          child: Center(
            child: Text("کاغذ  :  ${rubish.paper ?? 0} kg"),
          ),
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          radiusBottom: 16,
          radiusTop: 0,
          child: Center(
            child: Text("مخلوط  :  ${rubish.mix ?? 0} kg"),
          ),
        ),
        const SizedBox(height: 16),
        const NERequestTitle(
          title: "مکان ساختمان",
        ),
        const SizedBox(height: 4),
        DetailItemBox(
          child: Center(
            child: Text(rubish.address),
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
              Text("پلاک : ${rubish.plak}"),
              Text("کد پستی : ${rubish.postalCode}"),
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
                      lat: rubish.lat,
                      lng: rubish.lng,
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
                  latLng: LatLng(rubish.lat, rubish.lng),
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
