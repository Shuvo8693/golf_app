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
  String? sId;
  String? player;
  String? userName;
  String? visitingFrom;
  String? golfCourse;
  String? cityToPlay;
  String? fromDate;
  String? toDate;
  bool? isAccepted;
  bool? isReject;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LookingToPlayAttributes(
      {this.sId,
        this.player,
        this.userName,
        this.visitingFrom,
        this.golfCourse,
        this.cityToPlay,
        this.fromDate,
        this.toDate,
        this.isAccepted,
        this.isReject,
        this.createdAt,
        this.updatedAt,
        this.iV});

  LookingToPlayAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    player = json['player'];
    userName = json['userName'];
    visitingFrom = json['visitingFrom'];
    golfCourse = json['golfCourse'];
    cityToPlay = json['cityToPlay'];
    fromDate = json['fromDate'];
    toDate = json['tomDate'];
    isAccepted = json['isAccepted'];
    isReject = json['isReject'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
