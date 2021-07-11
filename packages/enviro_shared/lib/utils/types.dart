import 'package:flutter/cupertino.dart';

typedef FnWithOneParam<T> = void Function(T value);

typedef GoToChnageProfile = Future<void> Function({
  String? avatarUrl,
  String? email,
  String? name,
});

typedef PageReturn = Widget Function();
