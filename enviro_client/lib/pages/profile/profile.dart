import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/change_info/change_info.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfilePage(
      goToChnageProfile: ({avatarUrl, email, name}) => Navigator.push(
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
      ),
    );
  }
}
