class Banner {
  String image;
  String title;
  String url;

  Banner({
    this.image,
    this.title,
    this.url,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    image = json["image"]?.toString();
    title = json["title"]?.toString();
    url = json["url"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["image"] = image;
    data["title"] = title;
    data["url"] = url;
    return data;
  }
}

class BannerResponse {
  List<Banner> data;
  int status;

  BannerResponse({
    this.data,
    this.status,
  });

  BannerResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      var v = json["data"];
      var arr0 = List<Banner>();
      v.forEach((v) {
        arr0.add(Banner.fromJson(v));
      });
      data = arr0;
    }
    status = json["status"]?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (data != null) {
      var v = data;
      var arr0 = List();
//      v.forEach((v) {
//        arr0.add(v.toJson());
//      });
      data["data"] = arr0;
    }
    data["status"] = status;
    return data;
  }
}
