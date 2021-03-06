import 'dart:io';
import 'package:dio/dio.dart';

// typedef void RequestFinishedCallBack(Object responseObject);
typedef RequestSucceedBlock = void Function(Object responseObject); // 两种定义方式等价
typedef RequestFailBlock = void Function(int errorCode);

enum HTTPRequestMethod {
  method_get,
  method_post,
  method_put,
  method_delete,
  method_upload,
  method_head,
  method_patch
}

class FQNetworkManager extends Object {
  final String basicUrl;
  Dio dio;

  static FQNetworkManager _instance;
  factory FQNetworkManager(String basicUrl) {
    if (_instance == null) {
      _instance = FQNetworkManager._internal(basicUrl);

      Dio dio = Dio();
      dio.options.baseUrl = basicUrl;
      dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      dio.options.responseType = ResponseType.json;
      dio.options.receiveTimeout = 5000;

      _instance.dio = dio;
    }
    return _instance;
  }
  FQNetworkManager._internal(this.basicUrl);

  @pragma("Public")
  void requestUrl({String apiName, HTTPRequestMethod method, Map<String, dynamic> parameters, RequestSucceedBlock success, RequestFailBlock failure}) async {
    try {
      Response response;
      switch (method) {
        case HTTPRequestMethod.method_get: {
            response = await dio.get(apiName, queryParameters: parameters);
        }
          break;
        case HTTPRequestMethod.method_post: {
            response = await dio.post(apiName, data: parameters);
        }
          break;
        default:
          break;
      }
      
      if (response.statusCode == HttpStatus.ok) {
        if (success != null) {
          success(response.data);
        }
      } else {
        if (failure != null) {
          failure(response.statusCode);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
