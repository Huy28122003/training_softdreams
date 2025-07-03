import '../../../utils/constants/url_constants.dart';
import 'base/rest_client.dart';

class NoneAuthAppServerApiClient extends RestClient {
  NoneAuthAppServerApiClient() : super(baseUrl: UrlConstants.baseUrl);
}
