class ToDoModel {
  int? code;
  bool? success;
  int? timestamp;
  String? message;
  Data? data;

  ToDoModel({this.code, this.success, this.timestamp, this.message, this.data});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    timestamp = json['timestamp'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['timestamp'] = timestamp;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? description;
  bool? isCompleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.title,
      this.description,
      this.isCompleted,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
