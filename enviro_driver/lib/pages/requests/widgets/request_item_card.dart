import 'package:enviro_driver/pages/requests/widgets/avatar_modal.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RequestItemCardType {
  ready,
  ingoing,
}
const List<String> times = [
  "از 9  تا 12 ",
  "از 12 تا 15 ",
  "از 15 تا 18",
];

const text =
    "با این وجود بلومبرگ در گزارش خود به این موضوع اشاره می‌کند که این نخستین باری نیست که استیبل کوین تتر مورد اتهام قرار گرفته‌ و وضعیت فعالیت‌ آن‌ها مورد بررسی قرار می‌گیرد.  پیش از این نیز مقامات آمریکایی فعالیت‌های مربوط به تتر را مورد بازرسی قرار داده بودند.";

class RequestItemCard extends StatelessWidget {
  final RequestItemCardType requestItemCardType;
  final bool isSpectial;
  const RequestItemCard({
    Key? key,
    required this.requestItemCardType,
    required this.isSpectial,
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
                const RequestItemDataRow(
                  name: "مکان",
                  value: text,
                ),
                RequestItemDataRow(
                  name: "زمان",
                  value: times[0],
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
                        onPressed: () {
                          showAvatarModalBottomSheet(
                            builder: (context) => const Text("sina"),
                            context: context,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "مشاهده جزییات",
                            style: TextStyle(
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
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "قبول درخواست",
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
