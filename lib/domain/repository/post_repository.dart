import '../models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getListPosts({required int start, required int limit});

  Future<List<Post>> getSavedPosts();

  Future<void> savePost(Post post);

  Future<void> removePost(Post post);
}
