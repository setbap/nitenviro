import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AllReuqest extends StatelessWidget {
  const AllReuqest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return RequestItemCard(
          requestItemCardType: RequestItemCardType.ready,
          isSpectial: index % 2 == 0,
        );
      },
      itemCount: 10,
    );
  }
}
