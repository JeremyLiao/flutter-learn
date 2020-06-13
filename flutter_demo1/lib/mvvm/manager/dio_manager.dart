import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class ApiManager {
  static ApiManager _instance;

  static ApiManager getInstance() {
    if (_instance == null) {
      _instance = new ApiManager();
    }
    return _instance;
  }

  Dio _dio;

  ApiManager() {
    var options = new BaseOptions(
        connectTimeout: 5000, receiveTimeout: 3000, baseUrl: "https://gank.io");
    this._dio = Dio(options);
  }

  //get请求结构
  Future _get(String url, {Map<String, dynamic> params}) async {
    var response = await _dio.get(url, queryParameters: params);
    return response.data;
  }

  //post
  Future _post(String url, Map<String, dynamic> params) async {
    var response = await _dio.post(url, data: params);
    return response.data;
  }

  Observable post(String url, Map<String, dynamic> params) =>
      Observable.fromFuture(_post(url, params)).asBroadcastStream();

  Observable get(String url, {Map<String, dynamic> params}) =>
      Observable.fromFuture(_get(url, params: params)).asBroadcastStream();
}

class LocalInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    Map<String, String> headers = new Map();
    options.headers = headers;
    return super.onRequest(options);
  }
}
