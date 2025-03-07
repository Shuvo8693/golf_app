class TournamentNameModel {
  int? code;
  String? message;
  TournamentNameData? data;

  TournamentNameModel({this.code, this.message, this.data});

  TournamentNameModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? TournamentNameData.fromJson(json['data']) : null;
  }
}

class TournamentNameData {
  List<TournamentNameAttributes>? attributes;

  TournamentNameData({this.attributes});

  TournamentNameData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <TournamentNameAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(TournamentNameAttributes.fromJson(v));
      });
    }
  }
}

class TournamentNameAttributes {
  String? sId;
  String? clubName;
  String? typeName;
  String? tournamentName;

  TournamentNameAttributes({this.sId, this.clubName, this.typeName, this.tournamentName});

  TournamentNameAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    typeName = json['typeName'];
    tournamentName = json['tournamentName'];
  }
}
