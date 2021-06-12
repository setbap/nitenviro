import 'package:flutter/material.dart';
import 'package:nitenviro/shared_widget/background_circle_painter.dart';
import 'package:nitenviro/utils/colors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 40,
            center: Offset(size.width / 8, size.height / 8),
            isRightPrimary: false),
        CirclePaintInfo(
          radius: 15,
          center: Offset(size.width / 2, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 90,
          center: Offset(size.width, size.height / 4),
          isRightPrimary: false,
        ),
      ],
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              height: constraints.maxWidth / 9,
            ),
          ),
          CircleAvatar(
            maxRadius: 60,
            backgroundColor: yellowDarken,
            child: Image.network(
              "https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png",
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "تقی تاکسی پور",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "بابل",
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "|",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    " کد ملی  :${500400300}",
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text("تغییر"),
            ),
          )
        ],
      ),
    );
  }
}
