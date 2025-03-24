class GolferModel {
  int? code;
  String? message;
  GolferData? data;

  GolferModel({this.code, this.message, this.data});

  GolferModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new GolferData.fromJson(json['data']) : null;
  }
}

class GolferData {
  List<GolferAttributes>? attributes;

  GolferData({this.attributes});

  GolferData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <GolferAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(GolferAttributes.fromJson(v));
      });
    }
  }
}

class GolferAttributes {
  String? name;
  String? city;
  String? handicap;
  String? clubHandicap;
  Image? image;
  String? id;

  GolferAttributes(
      {this.name,
        this.city,
        this.handicap,
        this.clubHandicap,
        this.image,
        this.id});

  GolferAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    handicap = json['handicap'];
    clubHandicap = json['clubHandicap'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    id = json['id'];
  }
}

class Image {
  String? url;
  String? path;

  Image({this.url, this.path});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}
