import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/logic/recyclable_detector/recyclable_detector_cubit.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

const Map<String, String> _mapCategory = {
  "glass": "شیشه",
  "compost": "کمپست",
  "plastic": "پلاستیک",
  "paper": "کاغذ",
  "dangerous": "خطرناک",
  "metal": "فلزی",
};

const Map<String, String> _mapRecyclable = {
  "Not_Recyclable": "غیر قابل بازیافت",
  "Recyclable": " قابل بازیافت",
  "Limited": "بازیافت محدود",
};

Color recyclableColor(String state, double opacity) => state == "Not_Recyclable"
    ? Colors.red.withOpacity(opacity)
    : Colors.green.withOpacity(opacity);

class RecycleFinder extends StatelessWidget {
  const RecycleFinder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclableDetectorCubit,
        GenericApiState<List<RecyclableItems>>>(
      listener: (context, state) {
        if (state.isError) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                'Error',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              content: Text('an Error with you connection'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('dismiss'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<RecyclableDetectorCubit>().getAllItems();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'retry',
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverAppBar(
              title: TextField(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 96,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                              child: Text(_mapCategory.values.elementAt(index)),
                            ),
                            width: 56,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(56),
                            ),
                            height: 56,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: _mapCategory.length,
                  scrollDirection: Axis.horizontal,
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
                      const Text("تعداد 100 تا"),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = state.data![index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            item.name,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          Transform.scale(
                            scale: 0.8,
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              label: Text(
                                _mapRecyclable[item.recyclable] ?? "",
                                style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              padding: const EdgeInsets.all(0),
                              backgroundColor:
                                  recyclableColor(item.recyclable, 0.1),
                              labelPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              ),
                              side: BorderSide(
                                color: recyclableColor(item.recyclable, 0.5),
                                width: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(_mapCategory[item.category]??""),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: CircleAvatar(
                        radius: 32,
                        foregroundImage: NetworkImage(
                          "https://geonitenviro.nit.ac.ir/api" +
                              item.image[0].formats.thumbnail.url,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  );
                },
                childCount: state.data?.length,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.all(40))
          ],
        );
      },
    );
  }
}

/// Clip widget in wave shape
class WaveClipperTwo extends CustomClipper<Path> {
  const WaveClipperTwo();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width / 5, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
