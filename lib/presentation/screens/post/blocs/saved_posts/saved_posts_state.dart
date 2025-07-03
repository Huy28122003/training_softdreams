part of 'saved_posts_cubit.dart';

class SavedPostsState extends Equatable {
  final FormzSubmissionStatus status;
  final List<Post> posts;

  const SavedPostsState({
    this.status = FormzSubmissionStatus.initial,
    this.posts = const [],
  });

  SavedPostsState copyWith({
    FormzSubmissionStatus? status,
    List<Post>? posts,
  }) {
    return SavedPostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [status, posts];
}
