class TeeSheetModel {
  int? code;
  String? message;
  TeeSheetData? data;

  TeeSheetModel({this.code, this.message, this.data});

  TeeSheetModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new TeeSheetData.fromJson(json['data']) : null;
  }
}

class TeeSheetData {
  List<TeeSheetAttributes>? attributes;

  TeeSheetData({this.attributes});

  TeeSheetData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <TeeSheetAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(TeeSheetAttributes.fromJson(v));
      });
    }
  }
}

class TeeSheetAttributes {
  String? sId;
  String? tournametId;
  String? groupName;
  List<PlayerList>? playerList;
  String? teeSheetCreator;
  String? dateTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TeeSheetAttributes(
      {this.sId,
        this.tournametId,
        this.groupName,
        this.playerList,
        this.teeSheetCreator,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.iV});

  TeeSheetAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tournametId = json['tournametId'];
    groupName = json['groupName'];
    if (json['playerList'] != null) {
      playerList = <PlayerList>[];
      json['playerList'].forEach((v) {
        playerList!.add(new PlayerList.fromJson(v));
      });
    }
    teeSheetCreator = json['teeSheetCreator'];
    dateTime = json['dateTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class PlayerList {
  String? teebox;
  String? name;
  String? handicap;
  String? clubHandicap;
  String? id;

  PlayerList(
      {this.teebox, this.name, this.handicap, this.clubHandicap, this.id});

  PlayerList.fromJson(Map<String, dynamic> json) {
    teebox = json['teebox'];
    name = json['name'];
    handicap = json['handicap'];
    clubHandicap = json['clubHandicap'];
    id = json['id'];
  }
}
