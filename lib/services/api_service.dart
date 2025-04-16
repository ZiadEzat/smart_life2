// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:http/http.dart' as http;

class apiService {
  String _ipAddress;
  apiService({
    required String ipAddress,
  }) : _ipAddress = ipAddress;

  String get getIpAddress => _ipAddress;

  set setipAddress(String value) {
    _ipAddress = value;
  }

  Future<String> FetchData(String value) async {
    // send http request to desired ip from user's input
    final response = await http.get(Uri.parse('http://$_ipAddress/$value'));

    // return the response as a string
    return response.body;
  }
}
