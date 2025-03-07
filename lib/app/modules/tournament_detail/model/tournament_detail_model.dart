class TournamentDetailModel {
  int? code;
  String? message;
  TournamentDetailData? data;

  TournamentDetailModel({this.code, this.message, this.data});

  TournamentDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? TournamentDetailData.fromJson(json['data']) : null;
  }
}

class TournamentDetailData {
  TournamentDetailAttributes? attributes;

  TournamentDetailData({this.attributes});

  TournamentDetailData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? TournamentDetailAttributes.fromJson(json['attributes'])
        : null;
  }
}

class TournamentDetailAttributes {
  CourseLocation? courseLocation;
  String? sId;
  TournamentCreator? tournamentCreator;
  List<TournamentPlayersList>? tournamentPlayersList;
  String? tournamentName;
  String? clubName;
  String? tournamentType;
  String? typeName;
  String? date;
  String? time;
  String? city;
  String? courseName;
  bool? isApproved;
  bool? isRejected;
  double? courseRating;
  double? slopeRating;
  int? numberOfPlayers;
  double? handicapFromRange;
  double? handicapToRange;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isClose;

  TournamentDetailAttributes(
      {this.courseLocation,
        this.sId,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentName,
        this.tournamentType,
        this.typeName,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.isApproved,
        this.isRejected,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.handicapFromRange,
        this.handicapToRange,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isClose});

  TournamentDetailAttributes.fromJson(Map<String, dynamic> json) {
    courseLocation = json['courseLocation'] != null
        ? CourseLocation.fromJson(json['courseLocation'])
        : null;
    sId = json['_id'];
    tournamentCreator = json['tournamentCreator'] != null ? TournamentCreator.fromJson(json['tournamentCreator'] ):null;
    if (json['tournamentPlayersList'] != null) {
      tournamentPlayersList = <TournamentPlayersList>[];
      json['tournamentPlayersList'].forEach((v) {
        tournamentPlayersList!.add(TournamentPlayersList.fromJson(v));
      });
    }
    tournamentName = json['tournamentName'];
    clubName = json['clubName'];
    tournamentType = json['tournamentType'];
    typeName = json['typeName'];
    date = json['date'];
    time = json['time'];
    city = json['city'];
    courseName = json['courseName'];
    isApproved = json['isApproved'];
    isRejected = json['isRejected'];
    if(json['courseRating'] is int){
      courseRating =  (json['courseRating'] as int).toDouble();
    }else{
      courseRating = json['courseRating'];
    }

    if(json['slopeRating'] is int){
      slopeRating =  (json['slopeRating'] as int).toDouble();
    }else{
      slopeRating = json['slopeRating'];
    }
    numberOfPlayers = json['numberOfPlayers'];
    if(json['handicapFromRange'] is int){
      handicapFromRange =  (json['handicapFromRange'] as int).toDouble();
    }else{
      handicapFromRange = json['handicapFromRange'];
    }

    if(json['handicapToRange'] is int){
      handicapToRange =  (json['handicapToRange'] as int).toDouble();
    }else{
      handicapToRange = json['handicapToRange'];
    }
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isClose = json['isClose'];
  }

}

class CourseLocation {
  List<double>? coordinates;
  String? type;

  CourseLocation({this.coordinates, this.type});

  CourseLocation.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }
}

class TournamentPlayersList {
  String? name;
  String? handicap;
  String? clubHandicap;
  String? id;

  TournamentPlayersList({this.name, this.handicap, this.clubHandicap, this.id});

  TournamentPlayersList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    handicap = json['handicap'];
    clubHandicap = json['clubHandicap'];
    id = json['id'];
  }
}

class TournamentCreator {
  String? sId;
  String? name;

  TournamentCreator({this.sId, this.name});

  TournamentCreator.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    name = json['name'];
  }
}

class TournamentImage {
  String? url;
  String? path;

  TournamentImage({this.url, this.path});

  TournamentImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}
