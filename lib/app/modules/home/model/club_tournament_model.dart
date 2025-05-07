class ClubTournamentModel {
  String? message;
  String? status;
  int? statusCode;
  List<ClubTournamentData>? data;
  TournamentPagination? pagination;

  ClubTournamentModel(
      {this.message, this.status, this.statusCode, this.data, this.pagination});

  ClubTournamentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <ClubTournamentData>[];
      json['data'].forEach((v) {
        data!.add(ClubTournamentData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? TournamentPagination.fromJson(json['pagination'])
        : null;
  }
}

class ClubTournamentData {
  String? sId;
  String? clubName;
  String? tournamentCreator;
  List<String>? tournamentPlayersList;
  String? tournamentType;
  String? date;
  String? time;
  String? city;
  String? courseName;
  CourseLocation? courseLocation;
  double? courseRating;
  double? slopeRating;
  int? numberOfPlayers;
  double? gaggleLength;
  TournamentImage? tournamentImage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? distance;
  double? distanceToCurrentLocation;
  double? distanceToUser;

  ClubTournamentData(
      {this.sId,
        this.clubName,
        this.tournamentCreator,
        this.tournamentPlayersList,
        this.tournamentType,
        this.date,
        this.time,
        this.city,
        this.courseName,
        this.courseLocation,
        this.courseRating,
        this.slopeRating,
        this.numberOfPlayers,
        this.gaggleLength,
        this.tournamentImage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.distance,
        this.distanceToCurrentLocation,
        this.distanceToUser,
      });

  ClubTournamentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentCreator = json['tournamentCreator'];
    if (json['tournamentPlayersList'] != null && (json['tournamentPlayersList'] as List).isNotEmpty ) {
      tournamentPlayersList = <String>[];
      json['tournamentPlayersList'].forEach((v) {
        tournamentPlayersList!.add(v);
      });
    }
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
    if(json['gaggleLength'] is double){
      gaggleLength = json['gaggleLength'];
    } else if(json['gaggleLength'] is int){
      gaggleLength =double.tryParse(json['gaggleLength'].toString());
      print(gaggleLength);
    }

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['path'] = path;
    return data;
  }
}

class TournamentPagination {
  int? currentPage;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? totalItems;

  TournamentPagination(
      {this.currentPage,
        this.totalPages,
        this.nextPage,
        this.previousPage,
        this.totalItems});

  TournamentPagination.fromJson(Map<String, dynamic> json) {
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
