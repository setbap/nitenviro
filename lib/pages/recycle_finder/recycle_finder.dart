import 'package:flutter/material.dart';

class RecycleFinder extends StatelessWidget {
  const RecycleFinder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      CircleAvatar(
                        child: Container(),
                        foregroundColor: Colors.pink,
                        radius: 32,
                      )
                    ],
                  ),
                );
              },
              itemCount: 7,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
            (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                subtitle: Text("---"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Image.asset(
                    "assets/avatar.png",
                  ),
                ),
                tileColor: Colors.pink[(((index % 9) + 1) * 100)],
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            childCount: 30,
            findChildIndexCallback: (key) {
              print(key.toString());
            },
          ),
        )
      ],
    );
  }
}

/// Clip widget in wave shape
class WaveClipperTwo extends CustomClipper<Path> {
  const WaveClipperTwo();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width/5, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width , size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
