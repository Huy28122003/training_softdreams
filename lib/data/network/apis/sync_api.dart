// ignore_for_file: unused_field

import '../../../utils/extensions/date_ext.dart';
import '../client/none_auth_app_server_api_client.dart';

class SyncApi {
  SyncApi(this._restClient);

  final NoneAuthAppServerApiClient _restClient;

  Future<List<Map<String, dynamic>>> fetchPostData() async {
    try {
      // final resp = await _restClient.get(UrlConstants.syncPostUrl);
      final dynamic resp = [
        {
          'date': '2023-10-26 21:06:02.460Z',
          'new_data': {
            'posts': [
              {
                'id': 1,
                'title':
                    'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
                'body':
                    'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto'
              },
              {
                'id': 2,
                'title': 'qui est esse',
                'body':
                    'est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla'
              },
            ]
          },
          'update_data': null,
        },
        {
          'date': '2023-11-06 21:06:02.460Z',
          'new_data': null,
          'update_data': {
            'posts': [
              {
                'id': 1,
                'title': 'test',
              },
            ]
          }
        },
      ];

      List<Map<String, dynamic>> data =
          (resp as List).cast<Map<String, dynamic>>();

      data.sort((a, b) {
        final dateA = DateExt.parseUtc(a['date'] as String);
        final dateB = DateExt.parseUtc(b['date'] as String);
        if (dateA == null || dateB == null) return 0;
        return dateA.compareTo(dateB);
      });

      return data;
    } on Exception {
      rethrow;
    }
  }
}
