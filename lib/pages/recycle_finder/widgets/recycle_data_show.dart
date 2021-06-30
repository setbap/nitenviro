import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/widgets.dart';
import 'package:nitenviro/utils/colors.dart';
import 'package:public_nitenviro/public_nitenviro.dart';
import 'package:tuple/tuple.dart';

// from flutter files
typedef RefreshCallback = Future<void> Function();

class RecycleDataShow extends StatefulWidget {
  final List<RecyclableItems> data;
  final RefreshCallback onRefresh;

  const RecycleDataShow({
    Key? key,
    required this.data,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<RecycleDataShow> createState() => _RecycleDataShowState();
}

class _RecycleDataShowState extends State<RecycleDataShow> {
  String searchText = "";
  var categories = {...mapCategory};
  @override
  Widget build(BuildContext context) {
    final data = widget.data
        .where((element) =>
            element.name.contains(searchText) &&
            (categories[element.category]?.item2 ?? true))
        .toList();
    final selectedCategories =
        categories.values.where((element) => element.item2).toList();
    return Container(
      color: lightBorder,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: "نام پسماند( مثلا قوطی رب )",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            toolbarHeight: 75,
            backgroundColor: yellowDarken,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.onRefresh,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final category = categories.values.elementAt(index);
                          return InkWell(
                            onTap: () {
                              categories[category.item3] = Tuple3(
                                category.item1,
                                !category.item2,
                                category.item3,
                              );
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          category.item1,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: category.item2
                                          ? yellowDarken
                                          : yellowDarken.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(56),
                                      border: Border.all(
                                        width: 3,
                                        color: category.item2
                                            ? Colors.greenAccent
                                            : Colors.transparent,
                                      ),
                                    ),
                                    width: 64,
                                    height: 64,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            "دسته های انتخاب شده:",
                            textAlign: TextAlign.center,
                          ),
                          if (selectedCategories.isEmpty)
                            const Text(
                              "شما هیج دسته ای را انتخاب نکردید",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ...(selectedCategories
                              .map(
                                (e) => Chip(
                                  label: Text(e.item1),
                                  deleteButtonTooltipMessage: "حذف ${e.item1}",
                                  deleteIconColor: Colors.red.withOpacity(0.5),
                                  visualDensity: VisualDensity.compact,
                                  onDeleted: () {
                                    categories[e.item3] = Tuple3(
                                      e.item1,
                                      !e.item2,
                                      e.item3,
                                    );
                                    setState(() {});
                                  },
                                ),
                              )
                              .toList())
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("لیست پسماند ها"),
                            Text("تعداد: ${data.length}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (data.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Center(
                          child: Text(
                            "آیتمی با این مشخصات موجود نیست",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = data[index];
                        return OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                          closedColor: Colors.transparent,
                          openColor: lightBorder,
                          closedElevation: 0,
                          openBuilder: (context, action) {
                            return OpenItemDetail(
                              recyclableItems: item,
                            );
                          },
                          closedBuilder: (context, action) {
                            return CloseRecycleContainer(
                              onPressed: action,
                              recyclableItems: item,
                            );
                          },
                        );
                      },
                      childCount: data.length,
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsets.all(40))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CloseRecycleContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final RecyclableItems recyclableItems;
  const CloseRecycleContainer({
    Key? key,
    required this.onPressed,
    required this.recyclableItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: recyclableColor(recyclableItems.recyclable, 0.2),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          16,
        ),
        color: lightBorder,
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 0,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: mainYellow.withOpacity(0.1),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "https://geonitenviro.nit.ac.ir/api/" +
                        recyclableItems.image[0].formats.thumbnail.url,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [blueGradient, greenGradient],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  margin: const EdgeInsets.all(8),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          recyclableItems.name,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                          Text(
                            mapCategory[recyclableItems.category]?.item1 ?? "",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                          CustomChip(
                            item: recyclableItems.recyclable,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: recyclableColor(recyclableItems.recyclable, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
