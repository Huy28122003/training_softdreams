import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'blocs/demo_cubit.dart';

class DemoCubitScreen extends StatefulWidget {
  const DemoCubitScreen({super.key});

  @override
  State<DemoCubitScreen> createState() => _DemoCubitScreenState();
}

class _DemoCubitScreenState extends State<DemoCubitScreen> {
  late final DemoCubit _demoCubit;

  @override
  void initState() {
    super.initState();
    _demoCubit = context.read<DemoCubit>();
    _demoCubit.onFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo BLoC"),
      ),
      body: BlocBuilder<DemoCubit, DemoState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          if (state.status.isInProgress) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state.status.isFailure) {
            return SizedBox();
          }
          return Stack(
            children: [
              BlocBuilder<DemoCubit, DemoState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: Duration(seconds: 1),
                    color: _convertIntToColor(state.count),
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _demoCubit.onChangeBackground();
                  },
                  child: Text("Change background"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _convertIntToColor(int value) {
    return Color.fromARGB(255, 0 + value * 5, 255 - value * 10, 255);
  }
}
