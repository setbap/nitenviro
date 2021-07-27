import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AvatarBottomSheet extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final Widget child;
  final Animation<double> animation;

  const AvatarBottomSheet({
    Key? key,
    required this.child,
    required this.animation,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        color: Colors.transparent,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SafeArea(
                  bottom: false,
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, (1 - animation.value) * 100),
                      child: Opacity(
                        child: child,
                        opacity: max(0, animation.value * 2 - 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(
                              name ?? "حافظ محیط زیست",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          child: imageUrl == null
                              ? const Icon(
                                  CupertinoIcons.person,
                                )
                              : Image.network(imageUrl!),
                          radius: 24,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 12),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black12,
                            spreadRadius: 5,
                          )
                        ]),
                    width: double.infinity,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: child,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

Future<T?> showAvatarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result = await Navigator.of(context, rootNavigator: useRootNavigator)
      .push(ModalBottomSheetRoute<T>(
    builder: builder,
    containerBuilder: (_, animation, child) => AvatarBottomSheet(
      child: child,
      animation: animation,
    ),
    bounce: bounce,
    secondAnimationController: secondAnimation,
    expanded: expand,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    duration: duration,
  ));
  return result;
}
