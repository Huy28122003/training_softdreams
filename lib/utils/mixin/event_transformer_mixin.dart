import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

mixin EventTransformerMixin<E, S> on Bloc<E, S> {
  EventTransformer<Event> throttleTime<Event>(Duration duration) {
    return (events, mapper) {
      return events.throttleTime(duration).flatMap(mapper);
    };
  }

  EventTransformer<Event> debounceTime<Event>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).flatMap(mapper);
    };
  }
}
