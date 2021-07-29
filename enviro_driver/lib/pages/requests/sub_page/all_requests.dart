import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String imageUrl =
    "https://www.royalmobl.ir/wp-content/uploads/2019/11/04.jpg";

const text =
    "با این وجود بلومبرگ در گزارش خود به این موضوع اشاره می‌کند که این نخستین باری نیست که استیبل کوین تتر مورد اتهام قرار گرفته‌ و وضعیت فعالیت‌ آن‌ها مورد بررسی قرار می‌گیرد.  پیش از این نیز مقامات آمریکایی فعالیت‌های مربوط به تتر را مورد بازرسی قرار داده بودند.";

const place = "محمودآباد . خیابان امام بن بست امید";

class AllReuqest extends StatelessWidget {
  const AllReuqest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return RequestItemCard(
          detailBTNText: "مشاهده جزییات",
          acceptBTNText: "ثبت دریافت",
          time: times[index % 3],
          address: text,
          onDetailPress: () {
            showAvatarModalBottomSheet(
              builder: (context) {
                return RequestCardDetailModal(
                  lat: 36.37,
                  plak: 313,
                  postalCode: 4050607080,
                  lng: 52.264,
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
            // TODO : remove this line and get in init state
            context.read<GetRequestWithLocation>().getCurrentLocation();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("درخواست به لیست در حال اجرا اضافه شد"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          isSpectial: index % 2 == 0,
        );
      },
      itemCount: 10,
    );
  }
}
