class Top50GolfersModel {
  int? code;
  String? message;
  Top50GolferData? data;

  Top50GolfersModel({this.code, this.message, this.data});

  Top50GolfersModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Top50GolferData.fromJson(json['data']) : null;
  }
}

class Top50GolferData {
  List<Top50GolferAttributes>? attributes;

  Top50GolferData({this.attributes});

  Top50GolferData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <Top50GolferAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Top50GolferAttributes.fromJson(v));
      });
    }
  }
}

class Top50GolferAttributes {
  String? sId;
  String? name;
  String? handicap;
  Image? image;
  double? distance;

  Top50GolferAttributes({this.sId, this.name, this.handicap, this.image, this.distance});

  Top50GolferAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    handicap = json['handicap'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    distance = json['distance'];
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
