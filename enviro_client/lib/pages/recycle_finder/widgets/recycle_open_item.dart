import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/widgets.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

class OpenItemDetail extends StatelessWidget {
  final RecyclableItems recyclableItems;
  const OpenItemDetail({
    Key? key,
    required this.recyclableItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recyclableState = recyclableItems.recyclable;
    final _recycleColor = recyclableColor(recyclableState, 0.2);
    final imageFormat = recyclableItems.image[0].formats;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: yellowDarken,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              stretchModes: const [StretchMode.blurBackground],
              title: Text(
                recyclableItems.name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
              ),
              collapseMode: CollapseMode.parallax,
              background: CachedNetworkImage(
                imageUrl: "https://geonitenviro.nit.ac.ir/api/" +
                    (imageFormat.small?.url ?? imageFormat.thumbnail.url),
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black54,
                placeholder: (context, url) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        blueGradient.withOpacity(0.7),
                        greenGradient.withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InfoItemContainer(
              borderColor: _recycleColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("میزان بازبافت"),
                  CustomChipBase(
                    title: mapRecyclable[recyclableState]!,
                    backgroundColor: recyclableColor(recyclableState, 0.1),
                    borderColor: recyclableColor(recyclableState, 0.5),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: RecycleItemInfo(
              name: "نوع زباله",
              value: recyclableItems.dry ? "زباله خشک" : "زباله تر",
              unit: "",
              borderColor: _recycleColor,
            ),
          ),
          SliverToBoxAdapter(
            child: RecycleItemInfo(
              name: "رد پا آب",
              value: recyclableItems.waterFootprint,
              unit: recyclableItems.waterFootprintUnit,
              borderColor: _recycleColor,
            ),
          ),
          SliverToBoxAdapter(
            child: RecycleItemInfo(
              name: "رد پا کربن",
              value: recyclableItems.carbonFootprint,
              unit: recyclableItems.carbonFootprintUnit,
              borderColor: _recycleColor,
            ),
          ),
          if ((recyclableItems.useCases?.split("\n").length ?? 0) > 0)
            SliverToBoxAdapter(
              child: InfoItemContainer(
                borderColor: _recycleColor,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 0,
                  children: [
                    isRecyclable(recyclableState)
                        ? const Text("موارد مصرف:")
                        : const Text("موارد امحا:"),
                    ...(recyclableItems.useCases!
                        .split("\n")
                        .where((element) => element.trim().isNotEmpty)
                        .map(
                          (e) => CustomChipBase(
                            title: e,
                            backgroundColor:
                                recyclableColor(recyclableState, 0.1),
                            borderColor: recyclableColor(recyclableState, 0.5),
                          ),
                        )
                        .toList())
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: InfoItemContainer(
              borderColor: _recycleColor,
              child: Text(
                recyclableItems.description,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 160))
        ],
      ),
    );
  }
}

class RecycleItemInfo extends StatelessWidget {
  final String name;
  final Object? value;
  final String? unit;
  final Color borderColor;
  const RecycleItemInfo({
    Key? key,
    required this.name,
    this.value,
    this.unit,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox();
    }
    return InfoItemContainer(
      borderColor: borderColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "$value ${unit ?? ""}",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class InfoItemContainer extends StatelessWidget {
  final Color borderColor;
  final Widget child;
  const InfoItemContainer({
    Key? key,
    required this.borderColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(8),
      child: child,
    );
  }
}
