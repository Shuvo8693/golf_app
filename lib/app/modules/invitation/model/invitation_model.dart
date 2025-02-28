class InvitationModel {
  int? code;
  String? message;
  InvitationData? data;

  InvitationModel({this.code, this.message, this.data});

  InvitationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? InvitationData.fromJson(json['data']) : null;
  }
}

class InvitationData {
  List<InvitationAttributes>? attributes;

  InvitationData({this.attributes});

  InvitationData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <InvitationAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(InvitationAttributes.fromJson(v));
      });
    }
  }
}

class InvitationAttributes {
  String? sId;
  String? player;
  InviteSender? inviteSender;
  BigTournament? bigTournament;
  String? tournamentType;
  bool? isAccepted;
  bool? isRejected;
  DateTime? createdAt;
  String? updatedAt;
  int? iV;
  SmallTournament? smallTournament;

  InvitationAttributes(
      {this.sId,
        this.player,
        this.inviteSender,
        this.bigTournament,
        this.tournamentType,
        this.isAccepted,
        this.isRejected,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.smallTournament});

  InvitationAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    player = json['player'];
    inviteSender = json['inviteSender'] != null
        ? InviteSender.fromJson(json['inviteSender'])
        : null;
    if(json['bigTournament'] != null){
      bigTournament = json['bigTournament'] != null
          ? BigTournament.fromJson(json['bigTournament'])
          : null;
    }

    tournamentType = json['tournamentType'];
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    createdAt = DateTime.tryParse(json['createdAt'] as String);
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if(json['smallTournament'] != null){
      smallTournament = json['smallTournament'] != null
          ? SmallTournament.fromJson(json['smallTournament'])
          : null;
    }

  }
}

class InviteSender {
  String? name;
  Image? image;
  String? id;

  InviteSender({this.name, this.image, this.id});

  InviteSender.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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

class BigTournament {
  String? sId;
  String? clubName;
  String? courseName;

  BigTournament({this.sId, this.clubName, this.courseName});

  BigTournament.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    courseName = json['courseName'];
  }
}

class SmallTournament {
  String? sId;
  String? tournamentName;
  String? courseName;

  SmallTournament({this.sId, this.tournamentName, this.courseName});

  SmallTournament.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tournamentName = json['tournamentName'];
    courseName = json['courseName'];
  }
}
