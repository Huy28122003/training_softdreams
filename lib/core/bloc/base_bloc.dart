import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    // ignore: invalid_use_of_visible_for_testing_member
    super.emit(state);
  }

  @override
  void add(E event) {
    if (isClosed) return;
    super.add(event);
  }
}
