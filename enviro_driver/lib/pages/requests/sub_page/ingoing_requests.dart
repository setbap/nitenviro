import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/requests/sub_page/sub_page.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';

class IngoinRequest extends StatelessWidget {
  const IngoinRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return RequestItemCard(
          detailBTNText: "جزییات",
          acceptBTNText: "تایید دریافت",
          time: times[index % 3],
          address: text,
          onDetailPress: () {
            showAvatarModalBottomSheet(
              builder: (context) {
                return RequestCardDetailModal(
                  lat: 36.37,
                  lng: 52.264,
                  plak: 313,
                  postalCode: 4050607080,
                  address: text,
                  desc: text,
                  time: 1,
                  imageUrl: index % 2 == 0 ? imageUrl : "",
                  specialDesc: index % 2 == 0 ? text : "",
                );
              },
              name: "سینا ابراهیمی",
              context: context,
            );
          },
          onAcceptPress: () {
            showAvatarModalBottomSheet(
              builder: (context) {
                return const RequestCollectModal();
              },
              name: "سینا ابراهیمی",
              context: context,
            );
          },
          isSpectial: index % 2 == 0,
        );
      },
      itemCount: 10,
    );
  }
}
