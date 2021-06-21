import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/change_info/change_info.dart';
import 'package:nitenviro/pages/intro/intro.dart';
import 'package:nitenviro/shared_widget/background_circle_painter.dart';
import 'package:nitenviro/utils/colors.dart';

class Settings extends StatelessWidget {
  static const String path = "/settings";
  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 20,
            center: Offset(size.width / 8, size.height / 4),
            isRightPrimary: false),
        CirclePaintInfo(
          radius: 15,
          center: Offset(size.width / 2, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 20,
          center: Offset(size.width - 20, size.height / 4),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 75,
          center: Offset(50, size.height),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(size.width - 90, size.height),
          isRightPrimary: false,
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: yellowDarken,
              title: Text(
                "تنظیمات",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
              ),
              centerTitle: true,
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    SettingCardImage(),
                    SettingItem(
                      title: "تغییر مشخصات",
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return ChangeInfo(
                                name: null,
                                email: null,
                              );
                            },
                          ),
                        );
                      },
                      leadingIconData: Icons.info,
                    ),
                    SettingItem(
                      title: "درباره ما",
                      onPressed: () {},
                      leadingIconData: Icons.info,
                    ),
                    SettingItem(
                      title: "نمایش وب سایت",
                      onPressed: () {},
                      leadingIconData: Icons.info,
                    ),
                    SettingItem(
                      title: "منابع مجوز باز",
                      onPressed: () {
                        showLicensePage(
                          context: context,
                          applicationName: "Enviro App",
                        );
                      },
                      leadingIconData: Icons.info,
                    ),
                    SettingItem(
                      color: Colors.red,
                      title: "خروج از حساب کاربری",
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, IntroPage.path, (route) => false);
                      },
                      leadingIconData: Icons.exit_to_app,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingBaseCard extends StatelessWidget {
  final Widget child;
  const SettingBaseCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50.withOpacity(0.05),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
        side: BorderSide(
          color: lightBorder,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class SettingCardImage extends StatelessWidget {
  const SettingCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingBaseCard(
      child: Container(
        width: double.infinity,
        height: 180,
        padding: EdgeInsets.all(
          16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 56,
              backgroundColor: Colors.transparent,
              child: Image.network(
                "https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png",
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.account_circle,
                  size: 112,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("09110001122"),
                  Text("  |  "),
                  Text("ebr.sina@gmail.com"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final IconData leadingIconData;
  final String title;
  final VoidCallback onPressed;
  final Color? color;

  const SettingItem({
    Key? key,
    required this.title,
    required this.leadingIconData,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingBaseCard(
      child: ListTile(
        onTap: onPressed,
        leading: RadiantGradientMask(
          child: Icon(
            leadingIconData,
            size: 32,
            color: color ?? darkBorder,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: color ?? darkBorder, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: color ?? darkBorder,
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [blueGradient, greenGradient],
        tileMode: TileMode.clamp,
      ).createShader(bounds),
      child: child,
    );
  }
}