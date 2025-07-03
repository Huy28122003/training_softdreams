import '../../../domain/models/post.dart';
import '../client/none_auth_app_server_api_client.dart';

class PostApi {
  PostApi(this._restClient);

  final NoneAuthAppServerApiClient _restClient;

  Future<List<Post>> getListPosts({
    required int start,
    required int limit,
  }) async {
    try {
      final resp = await _restClient.get(
        'https://jsonplaceholder.typicode.com/posts',
        queryParameters: {
          '_start': start,
          '_limit': limit,
        },
      );

      return List.from(resp as Iterable)
          .cast<Map<String, dynamic>>()
          .map((json) => Post.fromJson(json))
          .toList();
    } on Exception {
      rethrow;
    }
  }
}
