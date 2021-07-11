import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/change_info/change_info.dart';

class Settings extends StatelessWidget {
  static const String path = "/settings";

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
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
