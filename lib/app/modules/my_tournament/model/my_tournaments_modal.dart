class MyTournamentModal {
  int? code;
  String? message;
  MyTournamentData? data;

  MyTournamentModal({this.code, this.message, this.data});

  MyTournamentModal.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? MyTournamentData.fromJson(json['data']) : null;
  }
}

class MyTournamentData {
  List<MyTournamentAttributes>? attributes;

  MyTournamentData({this.attributes});

  MyTournamentData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <MyTournamentAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(MyTournamentAttributes.fromJson(v));
      });
    }
  }
}

class MyTournamentAttributes {
  String? sId;
  String? clubName;
  TournamentCreator? tournamentCreator;
  List<String>? tournamentPlayersList;
  String? tournamentType;
  String? typeName;
  String? date;
  String? time;
  String? city;
  String? courseName;
  CourseLocation? courseLocation;
  bool? isApproved;
  bool? isRejected;
  double? courseRating;
  double? slopeRating;
  int? numberOfPlayers;
  int? gaggleLength;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? tournamentName;
  double? handicapFromRange;
  double? handicapToRange;
  bool? isClose;

  MyTournamentAttributes(
      {this.sId,
        this.clubName,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentType,
        this.typeName,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.courseLocation,
        this.isApproved,
        this.isRejected,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.gaggleLength,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.tournamentName,
        this.handicapFromRange,
        this.handicapToRange,
        this.isClose});

  MyTournamentAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentCreator = json['tournamentCreator'] != null ? TournamentCreator.fromJson(json['tournamentCreator'] ):null;
    tournamentPlayersList = json['tournamentPlayersList'].cast<String>();
    tournamentType = json['tournamentType'];
    typeName = json['typeName'];
    date = json['date'];
    time = json['time'];
    city = json['city'];
    courseName = json['courseName'];
    courseLocation = json['courseLocation'] != null
        ? CourseLocation.fromJson(json['courseLocation'])
        : null;
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
    gaggleLength = json['gaggleLength'];
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    tournamentName = json['tournamentName'];
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

class TournamentCreator {
  String? sId;
  String? name;

  TournamentCreator({this.sId, this.name});

  TournamentCreator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
