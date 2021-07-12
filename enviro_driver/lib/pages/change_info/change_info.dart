import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';

class ChangeInfo extends StatelessWidget {
  final String? name;
  final String? email;
  final String? avatarUrl;

  const ChangeInfo({
    Key? key,
    this.name,
    this.email,
    this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeInfoPage(
      avatarUrl: avatarUrl,
      name: name,
      email: email,
    );
  }
}
