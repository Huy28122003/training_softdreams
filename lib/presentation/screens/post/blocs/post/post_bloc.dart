import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/models/post.dart';
import '../../../../../domain/usecases/post/get_list_posts.dart';
import '../../../../../utils/mixin/event_transformer_mixin.dart';

part 'post_event.dart';
part 'post_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class PostBloc extends Bloc<PostEvent, PostState> with EventTransformerMixin {
  PostBloc({
    required this.getListPosts,
  }) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleTime(throttleDuration),
    );
  }

  final GetListPosts getListPosts;

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == PostStatus.initial) {
      final result = await getListPosts(GetListPostsParams(start: 0));
      return emit(result.fold(
        (failure) => state.copyWith(status: PostStatus.failure),
        (posts) => state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ),
      ));
    }

    final result = await getListPosts(GetListPostsParams(
      start: state.posts.length,
    ));
    emit(result.fold(
      (failure) => state.copyWith(status: PostStatus.failure),
      (posts) {
        if (posts.isEmpty) return state.copyWith(hasReachedMax: true);
        return state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        );
      },
    ));
  }
}
