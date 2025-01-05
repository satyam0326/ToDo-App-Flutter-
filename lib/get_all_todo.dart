class Model {
  int? code;
  bool? success;
  int? timestamp;
  String? message;
  List<Item>? items;
  Meta? meta;

  Model({
    this.code,
    this.success,
    this.timestamp,
    this.message,
    this.items,
    this.meta,
  });

  Model.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    timestamp = json['timestamp'];
    message = json['message'];
    if (json['items'] != null) {
      items = (json['items'] as List).map((v) => Item.fromJson(v)).toList();
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['timestamp'] = timestamp;
    data['message'] = message;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;

  Item({this.id, this.title, this.description, this.isCompleted});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['_id']; // Match the ID key in the API response
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }
}

class Meta {
  int? totalItems;
  int? totalPages;
  int? perPageItem;
  int? currentPage;
  int? pageSize;
  bool? hasMorePage;

  Meta({
    this.totalItems,
    this.totalPages,
    this.perPageItem,
    this.currentPage,
    this.pageSize,
    this.hasMorePage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
    perPageItem = json['per_page_item'];
    currentPage = json['current_page'];
    pageSize = json['page_size'];
    hasMorePage = json['has_more_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['total_pages'] = totalPages;
    data['per_page_item'] = perPageItem;
    data['current_page'] = currentPage;
    data['page_size'] = pageSize;
    data['has_more_page'] = hasMorePage;
    return data;
  }
}
