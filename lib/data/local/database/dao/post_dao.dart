import 'package:floor/floor.dart';

import '../../../../domain/models/post.dart';
import '../../../../utils/constants/strings.dart';

@dao
abstract class PostDao {
  @Query('SELECT * FROM $postsTableName')
  Future<List<Post>> getAllPosts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPost(Post post);

  @delete
  Future<void> deletePost(Post post);
}
