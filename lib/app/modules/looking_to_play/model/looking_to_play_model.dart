class LookingToPlayModel {
  int? code;
  String? message;
  LookingToPlayData? data;

  LookingToPlayModel({this.code, this.message, this.data});

  LookingToPlayModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? LookingToPlayData.fromJson(json['data']) : null;
  }
}

class LookingToPlayData {
  List<LookingToPlayAttributes>? attributes;

  LookingToPlayData({this.attributes});

  LookingToPlayData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <LookingToPlayAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(LookingToPlayAttributes.fromJson(v));
      });
    }
  }
}

class LookingToPlayAttributes {
  VisitingFrom? visitingFrom;
  String? sId;
  String? player;
  String? userName;
  String? golfCourse;
  String? fromDate;
  String? tomDate;
  bool? isAccepted;
  bool? isReject;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LookingToPlayAttributes(
      {this.visitingFrom,
        this.sId,
        this.player,
        this.userName,
        this.golfCourse,
        this.fromDate,
        this.tomDate,
        this.isAccepted,
        this.isReject,
        this.createdAt,
        this.updatedAt,
        this.iV});

  LookingToPlayAttributes.fromJson(Map<String, dynamic> json) {
    visitingFrom = json['visitingFrom'] != null
        ? VisitingFrom.fromJson(json['visitingFrom'])
        : null;
    sId = json['_id'];
    player = json['player'];
    userName = json['userName'];
    golfCourse = json['golfCourse'];
    fromDate = json['fromDate'];
    tomDate = json['tomDate'];
    isAccepted = json['isAccepted'];
    isReject = json['isReject'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class VisitingFrom {
  List<double>? coordinates;
  String? type;

  VisitingFrom({this.coordinates, this.type});

  VisitingFrom.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      coordinates = <double>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(v.toDouble());
      });
    }
    type = json['type'];
  }

  // Helper getters for easier access to longitude and latitude
  double? get longitude => coordinates != null && coordinates!.isNotEmpty ? coordinates![0] : null;
  double? get latitude => coordinates != null && coordinates!.length > 1 ? coordinates![1] : null;
}