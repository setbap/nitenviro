import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/pages.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 20,
            center: Offset(size.width / 8, size.height / 8),
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
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          UserInfoResult userInfo = UserInfoResult(
            id: -1,
            phone: "",
            createdAt: "",
          );
          if (state is UserInfoSuccess) {
            userInfo = state.user;
          }
          return ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  height: constraints.maxWidth / 9,
                ),
              ),
              CircleAvatar(
                maxRadius: 60,
                backgroundColor: Colors.transparent,
                child: Image.network(
                  userInfo.avatarUrl ??
                      "https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png",
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_circle,
                    size: 120,
                    color: yellowDarken,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Icon(
                      Icons.account_circle,
                      size: 120,
                      color: yellowDarken,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  userInfo.name ?? "حافظ محیط زیست",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileRequestBar(
                avatarUrl: userInfo.avatarUrl,
                email: userInfo.email,
                name: userInfo.name,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 0,
                  top: 24,
                  right: 24,
                  left: 24,
                ),
                decoration: const BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                    bottom: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    ProfileBoxInfo(
                      title: "شماره تماس",
                      icon: Icons.phone_enabled_outlined,
                      value: userInfo.phone,
                    ),
                    ProfileBoxInfo(
                      title: "ایمیل",
                      icon: Icons.mail,
                      value: userInfo.email ?? "ایمیل شما ثبت نشده است",
                    ),
                    ProfileBoxInfo(
                      title: "دریافت های تمام شده",
                      icon: Icons.circle,
                      value: userInfo.credit == 0
                          ? "دریافتی تا کنون نداشتید"
                          : "${userInfo.credit} بار",
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class ProfileRequestBar extends StatelessWidget {
  final String? name;
  final String? email;
  final String? avatarUrl;
  const ProfileRequestBar({
    Key? key,
    this.name,
    this.avatarUrl,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChangeInfo(
                    name: name,
                    email: email,
                    avatarUrl: avatarUrl,
                  );
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            primary: yellowSemiDarken,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                8,
              ),
              child: Text(
                "تغییر پروفایل",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: veryLightYellow,
                    ),
              ),
            ),
          ),
        ),
        // const SizedBox(width: 20),
        // OutlinedButton(
        //   onPressed: () {},
        //   style: OutlinedButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //       side: const BorderSide(
        //         width: 4,
        //       ),
        //       borderRadius: BorderRadius.circular(24),
        //     ),
        //   ),
        //   child: Center(
        //     child: Padding(
        //       padding: const EdgeInsets.all(
        //         8,
        //       ),
        //       child: Text(
        //         "درخواست تسویه",
        //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //               color: yellowSemiDarken,
        //             ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class ProfileBoxInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileBoxInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(width: 2, color: Colors.white),
      ),
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Icon(
              icon,
              color: yellowSemiDarken,
            ),
          ),
          Container(
            width: 1,
            height: 56,
            color: Colors.white.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 16),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
