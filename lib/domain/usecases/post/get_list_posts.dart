import 'package:dartz/dartz.dart';

import '../../../utils/constants/nums.dart';
import '../../error/failures.dart';
import '../../models/post.dart';
import '../../repository/post_repository.dart';
import '../usecase.dart';

class GetListPosts implements UseCase<List<Post>, GetListPostsParams> {
  GetListPosts(this.postRepository);

  final PostRepository postRepository;

  @override
  Future<Either<Failure, List<Post>>> call(GetListPostsParams params) async {
    try {
      final posts = await postRepository.getListPosts(
        start: params.start,
        limit: params.limit,
      );
      return Right(posts);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}

class GetListPostsParams {
  GetListPostsParams({
    required this.start,
    this.limit = defaultLimit,
  });

  final int start;
  final int limit;
}
