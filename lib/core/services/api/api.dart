import 'package:blogger_app/core/errors/exceptions.dart';
import 'package:blogger_app/core/services/sharedpreferences/shared_prefs.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../locator.dart';
import 'endpoints.dart';

class Api {
  SharedPrefs _sharedPrefs = locator<SharedPrefs>();

  ///[Post] call with user token
  secureHttpPostCall(String endpoint, Map<String, dynamic> params) async {
    return await checkInternetConnection(() async {
      String token = await _sharedPrefs.getToken();

      var url = "${Endpoints.apiURL.trim()}${endpoint.trim()}";
      Map<String, String> headers = {
        "token": token ?? "",
      };
      try {
        var response = await http.post(
          Uri.parse(url),
          body: params,
          headers: headers,
        );
        await checkForExceptions(response);
        final body = json.decode(response.body);
        return body;
      } catch (e) {
        print(e);
        throw e;
      }
    });
  }

  ///[Post] call without with user token
  Future httpPostCall(String endpoint, Map params) async {
    return await checkInternetConnection(() async {
      var url = "${Endpoints.apiURL.trim()}${endpoint.trim()}";
      // print(Endpoints.apiURL.trim());
      // print(endpoint.trim());
      try {
        var response = await http.post(
          Uri.parse(url),
          body: params,
        );
        await checkForExceptions(response);
        final body = json.decode(response.body);
        print(body);
        return body;
      } catch (e) {
        print(e);
        throw e;
      }
    });
  }

  ///[Get] call with with user token
  secureHttpGetcall(String endpoint) async {
    return await checkInternetConnection(() async {
      var url = "${Endpoints.apiURL.trim()}${endpoint.trim()}";
      String token = await _sharedPrefs.getToken();

      print(token);

      Map<String, String> headers = {
        "token": token,
      };

      print(url);
      try {
        var response = await http.get(
          Uri.parse(url),
          headers: headers,
        );

        await checkForExceptions(response);
        final body = json.decode(response.body);
        return body;
      } catch (e) {
        throw e;
      }
    });
  }

  ///[Get] call without with user token
  httpGetCall(String endpoint) async {
    var url = "${Endpoints.apiURL.trim()}${endpoint.trim()}";

    return await checkInternetConnection(() async {
      try {
        var response = await http.get(Uri.parse(url));
        await checkForExceptions(response);
        final body = json.decode(response.body);
        return body;
      } catch (e) {
        ////print(e);
        throw e;
      }
    });
  }

  ///helper method to check for error and return user friendly response
  Future checkForExceptions(
    http.Response response,
  ) {
    if (response.statusCode != 200) {
      print("Status Code: ${response.statusCode}");
      print("Error: ${response.body}");
      try {
        final body = json.decode(response.body);
        throw Exception(body['message']);
      } catch (e) {
        throw Exception(response.body.replaceAll('"', ''));
      }
    }
    return Future.value({});
  }

  ///helper method to check internet connection
  Future checkInternetConnection(Function apiCall) async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      return await apiCall();
    } else {
      throw NoInternetException();
    }
  }
}
