import 'package:enviro_shared/enviro_shared.dart';

import './widgets.dart';
import 'package:flutter/material.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class HistoryButton extends StatelessWidget {
  final SpacialRequest spacialRequest;
  const HistoryButton({
    Key? key,
    required this.spacialRequest,
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
                return HistoryDetail(spacialRequest: spacialRequest);
              },
            );
          },
          padding: const EdgeInsets.all(3),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (spacialRequest.isSpecial)
                const SpacialRoban(
                  robanColor: yellowSemiDarken,
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RequestItemDataRow(
                        name: "مکان", value: spacialRequest.building.address),
                    RequestItemDataRow(
                      name: "ساعت",
                      value:
                          "${spacialRequest.receivedTime!.hour}:${spacialRequest.receivedTime!.minute}",
                    ),
                    RequestItemDataRow(
                      name: "حجم (کیلوگرم)",
                      value: weightToText(
                        glass: spacialRequest.glassWeight,
                        mix: spacialRequest.mixedWeight,
                        metal: spacialRequest.metalWeight,
                        paper: spacialRequest.paperWeight,
                        plastic: spacialRequest.plasticWeight,
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

String weightToText(
    {required double metal,
    required double glass,
    required double mix,
    required double plastic,
    required double paper}) {
  var text = "";
  if (metal != 0.0) text += "فلز:$metal   ";
  if (glass != 0.0) text += "شیشه:$glass   ";
  if (plastic != 0.0) text += "پلاستیک:$plastic   ";
  if (paper != 0.0) text += "کاغذ:$paper   ";
  if (mix != 0.0) text += "مخلوط:$mix   ";

  return text;
}
