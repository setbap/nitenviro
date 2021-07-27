import 'package:enviro_driver/pages/requests/widgets/request_item_card.dart';
import 'package:flutter/material.dart';

class IngoinRequest extends StatelessWidget {
  const IngoinRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return RequestItemCard(
          requestItemCardType: RequestItemCardType.ingoing,
          isSpectial: index % 2 == 0,
        );
      },
      itemCount: 10,
    );
  }
}
