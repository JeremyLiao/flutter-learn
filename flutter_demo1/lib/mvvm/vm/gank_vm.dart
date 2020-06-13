import 'package:flutter/cupertino.dart';
import 'package:flutter_demo1/mvvm/bean/banner.dart';
import 'package:flutter_demo1/mvvm/model/gank_model.dart';
import 'dart:convert';

class GankViewModel with ChangeNotifier {
  var banners = List();

  void getBanner() {
    GankModel.getBanners()
        .doOnListen(() {
          banners = List();
          notifyListeners();
        })
        .map((res) => BannerResponse.fromJson(res))
        .listen((bannerResponse) {
          banners = bannerResponse.data;
          notifyListeners();
        });
  }
}
