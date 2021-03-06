import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/shared_widget/shared_widget.dart';
import 'package:enviro_shared/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  final GoToChnageProfile goToChnageProfile;

  const ProfilePage({
    Key? key,
    required this.goToChnageProfile,
  }) : super(key: key);

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
          return ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  height: constraints.maxWidth / 9,
                ),
              ),
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(
                      colors: [blueGradient, greenGradient],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Image.network(
                    state.user.avatarUrl,
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
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  state.user.name.isEmpty ? "???????? ???????? ????????" : state.user.name,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileRequestBar(
                pushProfilePage: () => goToChnageProfile(
                  avatarUrl: state.user.avatarUrl,
                  email: state.user.email,
                  name: state.user.name,
                ),
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
                      title: "?????????? ????????",
                      icon: Icons.phone_enabled_outlined,
                      value: state.user.phone,
                    ),
                    ProfileBoxInfo(
                      title: "??????????",
                      icon: Icons.mail,
                      value: state.user.email.isEmpty
                          ? "?????????? ?????? ?????? ???????? ??????"
                          : state.user.email,
                    ),
                    ProfileBoxInfo(
                      title: "???????????? ?????? ???????????? ??????",
                      icon: Icons.circle,
                      value: state.user.credit == 0
                          ? "?????????????? ???? ???????? ??????????????"
                          : "${state.user.credit} ????????????",
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
  final VoidCallback pushProfilePage;

  const ProfileRequestBar({
    Key? key,
    required this.pushProfilePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            pushProfilePage();
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
                "?????????? ??????????????",
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
        //         "?????????????? ??????????",
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
