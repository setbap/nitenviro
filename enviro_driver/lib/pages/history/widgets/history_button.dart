import 'package:enviro_driver/models/collected_rubbish.dart';
import 'package:enviro_driver/pages/history/widgets/widgets.dart';
import 'package:enviro_driver/pages/requests/widgets/avatar_modal.dart';
import 'package:enviro_driver/pages/requests/widgets/request_item_card.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:enviro_driver/utils/utils.dart';
import 'package:flutter/material.dart';

class HistoryButton extends StatelessWidget {
  final CollectedRubish collectedRubish;
  const HistoryButton({
    Key? key,
    required this.collectedRubish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        shadowColor: yellowSemiDarken.withOpacity(0.4),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            width: 2,
            color: yellowSemiDarken,
          ),
        ),
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: MaterialButton(
          onPressed: () {
            showAvatarModalBottomSheet(
              context: context,
              builder: (context) {
                return HistoryDetail(rubish: collectedRubish);
              },
            );
          },
          padding: const EdgeInsets.all(3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (collectedRubish.isSpectial)
                const SpacialRoban(
                  robanColor: yellowSemiDarken,
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RequestItemDataRow(
                        name: "مکان", value: collectedRubish.address),
                    RequestItemDataRow(
                      name: "ساعت",
                      value:
                          "${collectedRubish.collectedAt.hour}:${collectedRubish.collectedAt.minute}",
                    ),
                    RequestItemDataRow(
                      name: "حجم (کیلوگرم)",
                      value: weightToText(
                        glass: collectedRubish.glass,
                        mix: collectedRubish.mix,
                        metal: collectedRubish.metal,
                        paper: collectedRubish.paper,
                        plastic: collectedRubish.plastic,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
