class WinnerModel {
  int? code;
  String? message;
  WinnerData? data;

  WinnerModel({this.code, this.message, this.data});

  WinnerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? WinnerData.fromJson(json['data']) : null;
  }
}

class WinnerData {
  WinnerAttributes? attributes;

  WinnerData({this.attributes});

  WinnerData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? WinnerAttributes.fromJson(json['attributes'])
        : null;
  }
}

class WinnerAttributes {
  List<Skin>? skin;
  List<Kps>? kps;
  List<PlayerScore>? playerScore;
  List<ChalangeMatch>? chalangeMatch;

  WinnerAttributes({this.skin, this.kps, this.playerScore, this.chalangeMatch});

  WinnerAttributes.fromJson(Map<String, dynamic> json) {
    if (json['skin'] != null) {
      skin = <Skin>[];
      json['skin'].forEach((v) {
        skin!.add(Skin.fromJson(v));
      });
    }
    if (json['kps'] != null) {
      kps = <Kps>[];
      json['kps'].forEach((v) {
        kps!.add(Kps.fromJson(v));
      });
    }
    if (json['playerScore'] != null) {
      playerScore = <PlayerScore>[];
      json['playerScore'].forEach((v) {
        playerScore!.add(PlayerScore.fromJson(v));
      });
    }
    if (json['chalangeMatch'] != null) {
      chalangeMatch = <ChalangeMatch>[];
      json['chalangeMatch'].forEach((v) {
        chalangeMatch!.add(ChalangeMatch.fromJson(v));
      });
    }
  }
}

class Skin {
  String? sId;
  String? winnerCreator;
  String? tournament;
  SkinWinner? skinWinner;
  int? skinHole;
  String? skinScore;
  bool? skinIsPaid;
  int? skinPaidAmount;
  int? iV;

  Skin(
      {this.sId,
        this.winnerCreator,
        this.tournament,
        this.skinWinner,
        this.skinHole,
        this.skinScore,
        this.skinIsPaid,
        this.skinPaidAmount,
        this.iV});

  Skin.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    winnerCreator = json['winnerCreator'];
    tournament = json['tournament'];
    skinWinner = json['skinWinner'] != null
        ? SkinWinner.fromJson(json['skinWinner'])
        : null;
    skinHole = json['skinHole'];
    skinScore = json['skinScore'];
    skinIsPaid = json['skinIsPaid'];
    skinPaidAmount = json['skinPaidAmount'];
    iV = json['__v'];
  }
}

class SkinWinner {
  String? name;
  String? id;
  String? teeBox;

  SkinWinner({this.name, this.id,this.teeBox});

  SkinWinner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    teeBox = json['teebox'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Kps {
  String? sId;
  String? winnerCreator;
  String? tournament;
  SkinWinner? kpsWinner;
  String? kpsHole;
  int? kpsScore;
  int? kpsFeet;
  int? iV;

  Kps(
      {this.sId,
        this.winnerCreator,
        this.tournament,
        this.kpsWinner,
        this.kpsHole,
        this.kpsScore,
        this.kpsFeet,
        this.iV});

  Kps.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    winnerCreator = json['winnerCreator'];
    tournament = json['tournament'];
    kpsWinner = json['kpsWinner'] != null
        ? SkinWinner.fromJson(json['kpsWinner'])
        : null;
    kpsHole = json['kpsHole'];
    kpsScore = json['kpsScore'];
    kpsFeet = json['kpsFeet'];
    iV = json['__v'];
  }
}

class PlayerScore {
  String? sId;
  String? winnerCreator;
  String? tournament;
  SkinWinner? name;
  double? handicapIndex;
  int? score;
  int? iV;

  PlayerScore(
      {this.sId,
        this.winnerCreator,
        this.tournament,
        this.name,
        this.handicapIndex,
        this.score,
        this.iV});

  PlayerScore.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    winnerCreator = json['winnerCreator'];
    tournament = json['tournament'];
    name = json['name'] != null ? SkinWinner.fromJson(json['name']) : null;
    handicapIndex = json['handicapIndex'];
    score = json['score'];
    iV = json['__v'];
  }
}

class ChalangeMatch {
  String? sId;
  String? winnerCreator;
  String? tournament;
  SkinWinner? challengeWinner;
  int? winnerRound;
  SkinWinner? challengeLoser;
  int? loserRound;
  int? iV;

  ChalangeMatch(
      {this.sId,
        this.winnerCreator,
        this.tournament,
        this.challengeWinner,
        this.winnerRound,
        this.challengeLoser,
        this.loserRound,
        this.iV});

  ChalangeMatch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    winnerCreator = json['winnerCreator'];
    tournament = json['tournament'];
    challengeWinner = json['challengeWinner'] != null
        ? SkinWinner.fromJson(json['challengeWinner'])
        : null;
    winnerRound = json['winnerRound'];
    challengeLoser = json['challengeLoser'] != null
        ? SkinWinner.fromJson(json['challengeLoser'])
        : null;
    loserRound = json['loserRound'];
    iV = json['__v'];
  }
}
