import 'package:flutter_demo1/mvvm/manager/dio_manager.dart';
import 'package:rxdart/rxdart.dart';

class GankModel {
  static Observable getBanners() =>
      ApiManager.getInstance().get("/api/v2/banners");
}
