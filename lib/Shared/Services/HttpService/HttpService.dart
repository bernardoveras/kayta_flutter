import 'dart:io';
import 'package:http/http.dart';
import '../../Errors/Failure.dart';
import '../NetworkService/INetworkService.dart';
import '../../Services/HttpService/IHttpService.dart';

class HttpService implements IHttpService {
  HttpService(
    this.client,
    this.networkService, {
    this.considerarInternet = true,
    required this.baseUrl,
  });

  final Client client;
  final INetworkService networkService;
  final bool considerarInternet;

  @override
  late String baseUrl;

  @override
  Future<Response> get(String rota, {Map<String, String>? headers, Duration? timeout}) async {
    Map<String, String> _header = {"Content-Type": "application/json"};
    String _url = baseUrl.isNotEmpty ? '$baseUrl/$rota' : rota;

    if (headers != null) _header.addAll(headers);

    try {
      if (considerarInternet == true) {
        if (await networkService.isOffline()) {
          throw NetworkFailure();
        }
      }

      var result = await client
          .get(
            Uri.parse(_url),
            headers: _header,
          )
          .timeout(timeout ?? Duration(seconds: 10));

      return _handleResult(result);
    } on SocketException catch (e) {
      throw NetworkFailure(e.message);
    } on Failure catch (e) {
      throw ApiFailure(error: e);
    } catch (e) {
      throw ApiFailure();
    }
  }

  @override
  Future<Response> post(String rota, {body, Map<String, String>? headers, Duration? timeout}) async {
    Map<String, String> _header = {"Content-Type": "application/json"};
    String _url = baseUrl.isNotEmpty ? '$baseUrl/$rota' : rota;

    if (headers != null) _header.addAll(headers);

    try {
      if (considerarInternet == true) {
        if (await networkService.isOffline()) {
          throw NetworkFailure();
        }
      }

      var result = await client
          .post(
            Uri.parse(_url),
            body: body,
            headers: _header,
          )
          .timeout(timeout ?? Duration(seconds: 10));

      return _handleResult(result);
    } on Failure catch (e) {
      throw ApiFailure(error: e);
    } catch (e) {
      throw ApiFailure();
    }
  }

  Response _handleResult(Response response) {
    if (response.body.isNotEmpty && response.statusCode == 200) {
      return response;
    } else {
      throw _handleError(response);
    }
  }

  Failure _handleError(Response response) {
    if (response.statusCode == 401) {
      throw UnauthorizedFailure("Não autorizado.");
    } else {
      throw ApiException.fromResponse(response);
    }
  }
}
