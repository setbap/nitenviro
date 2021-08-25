import 'package:enviro_shared/enviro_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/material.dart';

class RequestItemCard extends StatelessWidget {
  final String address;
  final String time;
  final double? lat;
  final double? lng;
  final String detailBTNText;
  final String acceptBTNText;
  final bool isSpectial;
  final String? phoneNumber;
  final VoidCallback? onDetailPress;
  final VoidCallback? onAcceptPress;

  const RequestItemCard({
    Key? key,
    required this.address,
    required this.time,
    required this.detailBTNText,
    required this.acceptBTNText,
    required this.isSpectial,
    this.onDetailPress,
    this.onAcceptPress,
    this.phoneNumber,
    this.lat,
    this.lng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: phoneNumber != null ? 200 : 160,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: darkGreen, width: 2),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: darkBorderOpa,
            offset: Offset(0, 8),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isSpectial) const SpacialRoban(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RequestItemDataRow(
                  name: "مکان",
                  value: address,
                ),
                RequestItemDataRow(
                  name: "زمان",
                  value: time,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: darkGreen,
                              width: 4,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onPressed: onDetailPress,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            detailBTNText,
                            style: const TextStyle(
                              color: mediumGreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              onAcceptPress == null ? Colors.grey : mediumGreen,
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: darkGreen,
                              width: 4,
                            ),
                          ),
                        ),
                        onPressed: onAcceptPress,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            acceptBTNText,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (phoneNumber != null && lng != null && lat != null)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(
                              side: BorderSide(
                                color: yellowDarken,
                                width: 1,
                              ),
                            ),
                          ),
                          onPressed: () {
                            url_launcher.launch('tel:$phoneNumber');
                          },
                          icon: const Icon(
                            Icons.phone_enabled_outlined,
                            color: yellowDarken,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "برقرار تماس",
                              style: TextStyle(
                                color: yellowDarken,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          onPressed: () {
                            url_launcher.launch(
                              // "geo:$lat,$lng",
                              // "geo:37.423156,-122.084917?q=37.423156,-122.084917",
                              // "http://maps.google.com/maps?daddr=$lat,$lng",
                              "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng",
                            );
                          },
                          icon: const Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "مسیربابی",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RequestItemDataRow extends StatelessWidget {
  final String name;
  final int maxLines;
  final String value;
  const RequestItemDataRow({
    Key? key,
    required this.name,
    required this.value,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          name,
          style: textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class SpacialRoban extends StatelessWidget {
  final Color robanColor;
  const SpacialRoban({Key? key, this.robanColor = darkGreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..setRotationZ(3.14 / 4),
      origin: const Offset(35, 35),
      child: Align(
        alignment: Alignment.topLeft,
        child: ColoredBox(
          child: const SizedBox(
            height: 70,
            width: 15,
          ),
          color: robanColor,
        ),
      ),
    );
  }
}
