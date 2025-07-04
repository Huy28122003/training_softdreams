import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc/demo_bloc_bloc.dart';

class DemoBlocScreen extends StatefulWidget {
  const DemoBlocScreen({super.key});

  @override
  State<DemoBlocScreen> createState() => _DemoBlocScreenState();
}

class _DemoBlocScreenState extends State<DemoBlocScreen> {
  late final DemoBlocBloc _demoBlocBloc;

  @override
  void initState() {
    super.initState();
    _demoBlocBloc = context.read<DemoBlocBloc>();
  }

  @override
  void dispose() {
    _demoBlocBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo BLoC"),
      ),
      body: BlocBuilder<DemoBlocBloc, DemoBlocState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          if (state.status.isInProgress) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state.status.isFailure) {
            return SizedBox();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<DemoBlocBloc, DemoBlocState>(
                  buildWhen: (prev, curr) => prev.count != curr.count,
                  builder: (context, state) {
                    return Text(
                      state.count.toString(),
                      style: TextStyle(fontSize: 30),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _demoBlocBloc.onStartTimer();
                  },
                  child: Text("Start"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
