import 'package:enviro_shared/enviro_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestItemCard extends StatelessWidget {
  final String address;
  final String time;
  final String detailBTNText;
  final String acceptBTNText;
  final bool isSpectial;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                          backgroundColor: mediumGreen,
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: darkGreen,
                              width: 4,
                            ),
                          ),
                        ),
                        onPressed: onAcceptPress,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "ثبت دریافت",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
  final String value;
  const RequestItemDataRow({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class SpacialRoban extends StatelessWidget {
  const SpacialRoban({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..setRotationZ(3.14 / 4),
      origin: const Offset(35, 35),
      child: const Align(
        alignment: Alignment.topLeft,
        child: ColoredBox(
          child: SizedBox(
            height: 70,
            width: 15,
          ),
          color: darkGreen,
        ),
      ),
    );
  }
}
