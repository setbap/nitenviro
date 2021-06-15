import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/widgets.dart';
import 'package:nitenviro/utils/colors.dart';
import 'package:public_nitenviro/public_nitenviro.dart';
import 'package:tuple/tuple.dart';

class RecycleDataShow extends StatefulWidget {
  final List<RecyclableItems> data;

  const RecycleDataShow({
    Key? key,
    required this.data,
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
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: yellowDarken,
          ),
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
                          Container(
                            child: Center(
                              child: Text(
                                category.item1,
                              ),
                            ),
                            width: 56,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(56),
                              border: Border.all(
                                width: 3,
                                color: category.item2
                                    ? Colors.greenAccent
                                    : Colors.transparent,
                              ),
                            ),
                            height: 56,
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
                children: selectedCategories
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
                    .toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
          if (data.length == 0)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 48),
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
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        // padding:
                        //     const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: recyclableColor(item.recyclable, 0.2),
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
                              action();
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
                                    child: Image.network(
                                      "https://geonitenviro.nit.ac.ir/api" +
                                          item.image[0].formats.thumbnail.url,
                                    ),
                                    margin: const EdgeInsets.all(8),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            item.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Row(
                                          children: [
                                            Text(
                                              mapCategory[item.category]
                                                      ?.item1 ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                            CustomChip(
                                              item: item.recyclable,
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
                                        color:
                                            recyclableColor(item.recyclable, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              childCount: data.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.all(40))
        ],
      ),
    );
  }
}
