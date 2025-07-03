import 'package:bloc/bloc.dart';

import '../../../../../domain/models/post.dart';
import '../../../../../domain/usecases/post/save_post.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final SavePost savePost;

  PostDetailsCubit({
    required this.savePost,
  }) : super(const PostDetailsState());

  Future<void> save(Post post) async {
    await savePost(post);
  }
}
