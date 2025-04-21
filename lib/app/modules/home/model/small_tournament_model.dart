class SmallTournamentModel {
  String? message;
  String? status;
  int? statusCode;
  List<SmallTournamentData>? data;
  SmallTournamentPagination? pagination;

  SmallTournamentModel(
      {this.message, this.status, this.statusCode, this.data, this.pagination});

  SmallTournamentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <SmallTournamentData>[];
      json['data'].forEach((v) {
        data!.add(SmallTournamentData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? SmallTournamentPagination.fromJson(json['pagination'])
        : null;
  }
}

class SmallTournamentData {
  String? sId;
  String? tournamentCreator;
  List<String>? tournamentPlayersList;
  String? tournamentName;
  String? tournamentType;
  String? date;
  String? time;
  String? city;
  String? courseName;
  CourseLocation? courseLocation;
  double? courseRating;
  double? slopeRating;
  int? numberOfPlayers;
  int? handicapFromRange;
  int? handicapToRange;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? distance;
  double? distanceToCurrentLocation;
  double? distanceToUser;

  SmallTournamentData(
      {this.sId,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentName,
        this.tournamentType,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.courseLocation,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.handicapFromRange,
        this.handicapToRange,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.distance,
        this.distanceToCurrentLocation,
        this.distanceToUser});

  SmallTournamentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tournamentCreator = json['tournamentCreator'];
    if (json['tournamentPlayersList'] != null) {
      tournamentPlayersList = <String>[];
      json['tournamentPlayersList'].forEach((v) {
        tournamentPlayersList!.add(v);
      });
    }
    tournamentName = json['tournamentName'];
    tournamentType = json['tournamentType'];
    date = json['date'];
    time = json['time'];
    city = json['city'];
    courseName = json['courseName'];
    courseLocation = json['courseLocation'] != null
        ? CourseLocation.fromJson(json['courseLocation'])
        : null;
    if( json['courseRating'] is double){
      courseRating = json['courseRating'];
    }else if(json['courseRating'] is int){
      courseRating =double.tryParse(json['courseRating'].toString());
    }
    if( json['slopeRating'] is double){
      slopeRating = json['slopeRating'];
    }else if(json['slopeRating'] is int){
      slopeRating =double.tryParse(json['slopeRating'].toString());
    }
    numberOfPlayers = json['numberOfPlayers'];
    handicapFromRange = json['handicapFromRange'];
    handicapToRange = json['handicapToRange'];
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];

    if( json['distance'] is double){
      distance = json['distance'];
    }else if(json['distance'] is int){
      distance =double.tryParse(json['distance'].toString());
    }
    if( json['distanceToCurrentLocation'] is double){
      distanceToCurrentLocation = json['distanceToCurrentLocation'];
    }else if(json['distanceToCurrentLocation'] is int){
      distanceToCurrentLocation =double.tryParse(json['distanceToCurrentLocation'].toString());
    }

    if( json['distanceToUser'] is double){
      distanceToUser = json['distanceToUser'];
    }else if(json['distanceToUser'] is int){
      distanceToUser =double.tryParse(json['distanceToUser'].toString());
    }
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

class TournamentImage {
  String? url;
  String? path;

  TournamentImage({this.url, this.path});

  TournamentImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class SmallTournamentPagination {
  int? currentPage;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? totalItems;

  SmallTournamentPagination(
      {this.currentPage,
        this.totalPages,
        this.nextPage,
        this.previousPage,
        this.totalItems});

  SmallTournamentPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    totalItems = json['totalItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['nextPage'] = nextPage;
    data['previousPage'] = previousPage;
    data['totalItems'] = totalItems;
    return data;
  }
}
