import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../domain/models/post.dart';
import '../../../../../domain/usecases/post/get_list_saved_posts.dart';
import '../../../../../domain/usecases/post/remove_saved_post.dart';

part 'saved_posts_state.dart';

class SavedPostsCubit extends Cubit<SavedPostsState> {
  final GetListSavedPosts getListSavedPosts;
  final RemoveSavedPost removeSavedPost;

  SavedPostsCubit({
    required this.getListSavedPosts,
    required this.removeSavedPost,
  }) : super(const SavedPostsState());

  Future<void> getAllPosts() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    final result = await getListSavedPosts();

    emit(
      result.fold(
        (failure) => state.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
        (posts) => state.copyWith(
          status: FormzSubmissionStatus.success,
          posts: posts,
        ),
      ),
    );
  }

  Future<void> removePost(Post post) async {
    final result = await removeSavedPost(post);
    final success = result.fold((l) => false, (r) => r);

    if (!success) return;

    await getAllPosts();
  }
}
