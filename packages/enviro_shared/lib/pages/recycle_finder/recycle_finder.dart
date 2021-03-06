import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/pages/recycle_finder/widgets/widgets.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

class RecycleFinderPage extends StatelessWidget {
  const RecycleFinderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecyclableDetectorCubit,
        GenericApiState<List<RecyclableItems>>>(
      listener: (context, state) {
        if (state.isError && !state.isLoading) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'خطا',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              content: const Text('مشکلی در ارتباط با سرور به وجود آمده است'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('بی خیال'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<RecyclableDetectorCubit>().getAllItems();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'تلاش دوباره',
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.data == null && state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "مشکل در دریافت اطلاعات",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  child: const Text("دریافت مجدد"),
                  onPressed: () {
                    context.read<RecyclableDetectorCubit>().getAllItems();
                  },
                ),
              ],
            ),
          );
        }
        return RecycleDataShow(
          data: state.data!,
          onRefresh: () async {
            await context.read<RecyclableDetectorCubit>().getAllItems();
          },
        );
      },
    );
  }
}
