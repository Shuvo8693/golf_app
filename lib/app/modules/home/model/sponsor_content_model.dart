class SponsorContentModel {
  int? code;
  String? message;
  SponsorContentData? data;

  SponsorContentModel({this.code, this.message, this.data});

  SponsorContentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new SponsorContentData.fromJson(json['data']) : null;
  }
}

class SponsorContentData {
  List<SponsorContentAttributes>? attributes;

  SponsorContentData({this.attributes});

  SponsorContentData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <SponsorContentAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new SponsorContentAttributes.fromJson(v));
      });
    }
  }
}

class SponsorContentAttributes {
  String? sId;
  String? sponserCreator;
  SponserImage? sponserImage;
  String? name;
  Location? location;
  String? link;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? distance;

  SponsorContentAttributes(
      {this.sId,
        this.sponserCreator,
        this.sponserImage,
        this.name,
        this.location,
        this.link,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.distance});

  SponsorContentAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sponserCreator = json['sponserCreator'];
    sponserImage = json['sponserImage'] != null
        ? new SponserImage.fromJson(json['sponserImage'])
        : null;
    name = json['name'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    link = json['link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    distance = json['distance'];
  }
}

class SponserImage {
  String? url;
  String? path;

  SponserImage({this.url, this.path});

  SponserImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }
}
