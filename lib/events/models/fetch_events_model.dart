class FetchEventsModel {
  final List<Document>? documents;

  FetchEventsModel({this.documents});

  factory FetchEventsModel.fromJson(Map<String, dynamic> json) {
    return FetchEventsModel(
      documents: json['documents'] != null
          ? List<Document>.from(
          json['documents'].map((doc) => Document.fromJson(doc)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (documents != null)
      'documents': documents!.map((doc) => doc.toJson()).toList(),
  };
}

class Document {
  final String? name;
  final Fields? fields;
  final String? createTime;
  final String? updateTime;

  Document({this.name, this.fields, this.createTime, this.updateTime});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      name: json['name'],
      fields:
      json['fields'] != null ? Fields.fromJson(json['fields']) : null,
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
    if (fields != null) 'fields': fields!.toJson(),
    if (createTime != null) 'createTime': createTime,
    if (updateTime != null) 'updateTime': updateTime,
  };
}

class Fields {
  final Value? title;
  final Value? description;
  final Value? date;
  final TotalBookedCount? totalBookedCount;
  final BookedUsers? bookedUsers;

  Fields({
    this.title,
    this.description,
    this.date,
    this.totalBookedCount,
    this.bookedUsers,
  });

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(
      title: json['title'] != null ? Value.fromJson(json['title']) : null,
      description:
      json['description'] != null ? Value.fromJson(json['description']) : null,
      date: json['date'] != null ? Value.fromJson(json['date']) : null,
      totalBookedCount: json['totalBookedCount'] != null
          ? TotalBookedCount.fromJson(json['totalBookedCount'])
          : null,
      bookedUsers: json['bookedUsers'] != null
          ? BookedUsers.fromJson(json['bookedUsers'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (title != null) 'title': title!.toJson(),
    if (description != null) 'description': description!.toJson(),
    if (date != null) 'date': date!.toJson(),
    if (totalBookedCount != null)
      'totalBookedCount': totalBookedCount!.toJson(),
    if (bookedUsers != null) 'bookedUsers': bookedUsers!.toJson(),
  };
}

class Value {
  final String? stringValue;

  Value({this.stringValue});

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(stringValue: json['stringValue']);
  }

  Map<String, dynamic> toJson() => {
    if (stringValue != null) 'stringValue': stringValue,
  };
}

class TotalBookedCount {
  final String? integerValue;

  TotalBookedCount({this.integerValue});

  factory TotalBookedCount.fromJson(Map<String, dynamic> json) {
    return TotalBookedCount(integerValue: json['integerValue']);
  }

  Map<String, dynamic> toJson() => {
    if (integerValue != null) 'integerValue': integerValue,
  };
}

class BookedUsers {
  final ArrayValue? arrayValue;

  BookedUsers({this.arrayValue});

  factory BookedUsers.fromJson(Map<String, dynamic> json) {
    return BookedUsers(
      arrayValue: json['arrayValue'] != null
          ? ArrayValue.fromJson(json['arrayValue'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (arrayValue != null) 'arrayValue': arrayValue!.toJson(),
  };
}

class ArrayValue {
  final List<Value>? values;

  ArrayValue({this.values});

  factory ArrayValue.fromJson(Map<String, dynamic> json) {
    var valuesJson = json['values'] as List?;
    return ArrayValue(
      values: valuesJson != null
          ? valuesJson.map((v) => Value.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    if (values != null)
      'values': values!.map((v) => v.toJson()).toList(),
  };
}
