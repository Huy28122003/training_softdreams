import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../models/post.dart';
import '../../repository/post_repository.dart';
import '../usecase.dart';

class GetListSavedPosts implements UseCase<List<Post>, NoParams> {
  GetListSavedPosts(this.postRepository);

  final PostRepository postRepository;

  @override
  Future<Either<Failure, List<Post>>> call([NoParams? params]) async {
    try {
      final posts = await postRepository.getSavedPosts();
      return Right(posts);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
