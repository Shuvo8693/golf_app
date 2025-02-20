class RequestToPlayModel {
  String? message;
  String? status;
  int? statusCode;
  List<RequestToPlayData>? data;
  Pagination? pagination;

  RequestToPlayModel(
      {this.message, this.status, this.statusCode, this.data, this.pagination});

  RequestToPlayModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <RequestToPlayData>[];
      json['data'].forEach((v) {
        data!.add(RequestToPlayData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class RequestToPlayData {
  String? sId;
  RequestedUser? requestedUser;
  String? tournamentCreator;
  Tournament? tournament;
  String? tournamentType;
  bool? isAccepted;
  bool? isCancel;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RequestToPlayData(
      {this.sId,
        this.requestedUser,
        this.tournamentCreator,
        this.tournament,
        this.tournamentType,
        this.isAccepted,
        this.isCancel,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RequestToPlayData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requestedUser = json['requestedUser'] != null
        ? RequestedUser.fromJson(json['requestedUser'])
        : null;
    tournamentCreator = json['tournamentcreator'];
    tournament = json['tournament'] != null
        ? Tournament.fromJson(json['tournament'])
        : null;
    tournamentType = json['tournamentType'];
    isAccepted = json['isAccepted'];
    isCancel = json['isCancale'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class RequestedUser {
  String? name;
  String? id;

  RequestedUser({this.name, this.id});

  RequestedUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class Tournament {
  String? sId;
  String? clubName;
  String? tournamentType;
  String? date;
  String? time;
  String? courseName;

  Tournament(
      {this.sId,
        this.clubName,
        this.tournamentType,
        this.date,
        this.time,
        this.courseName});

  Tournament.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentType = json['tournamentType'];
    date = json['date'];
    time = json['time'];
    courseName = json['courseName'];
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  int? totalItems;

  Pagination(
      {this.currentPage,
        this.totalPages,
        this.nextPage,
        this.previousPage,
        this.totalItems});

  Pagination.fromJson(Map<String, dynamic> json) {
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
