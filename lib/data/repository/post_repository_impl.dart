import '../../domain/models/post.dart';
import '../../domain/repository/post_repository.dart';
import '../local/database/app_database.dart';
import '../network/apis/post_api.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl({
    required this.postApi,
    required this.database,
  });

  final PostApi postApi;
  final AppDatabase database;

  @override
  Future<List<Post>> getListPosts({
    required int start,
    required int limit,
  }) {
    return postApi.getListPosts(start: start, limit: limit);
  }

  @override
  Future<List<Post>> getSavedPosts() {
    return database.postDao.getAllPosts();
  }

  @override
  Future<void> removePost(Post post) {
    return database.postDao.deletePost(post);
  }

  @override
  Future<void> savePost(Post post) {
    return database.postDao.insertPost(post);
  }
}
