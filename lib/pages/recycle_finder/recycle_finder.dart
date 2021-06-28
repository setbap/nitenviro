import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/widgets.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

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
                  child: Text(
                    'تلاش دوباره',
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.data == null || state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RecycleDataShow(data: state.data!);
      },
    );
  }
}
