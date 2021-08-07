class BooksChapter {
    Data data;
    int code;
    String msg;

    BooksChapter({this.data, this.code, this.msg});

    factory BooksChapter.fromJson(Map<String, dynamic> json) {
        return BooksChapter(
            data: json['data'] != null ? Data.fromJson(json['data']) : null, 
            code: json['code'], 
            msg: json['msg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['msg'] = this.msg;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    List<DataX> data;
    int count;

    Data({this.data, this.count});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            data: json['data'] != null ? (json['data'] as List).map((i) => DataX.fromJson(i)).toList() : null, 
            count: json['count'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class DataX {
    String chapterId;
    String creationTime;
    String fictionId;
    int fictionVariableId;
    int id;
    String title;

    DataX({this.chapterId, this.creationTime, this.fictionId, this.fictionVariableId, this.id, this.title});

    factory DataX.fromJson(Map<String, dynamic> json) {
        return DataX(
            chapterId: json['chapterId'], 
            creationTime: json['creationTime'], 
            fictionId: json['fictionId'], 
            fictionVariableId: json['fictionVariableId'], 
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chapterId'] = this.chapterId;
        data['creationTime'] = this.creationTime;
        data['fictionId'] = this.fictionId;
        data['fictionVariableId'] = this.fictionVariableId;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}