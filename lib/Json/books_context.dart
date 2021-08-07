class BooksContext {
    Data data;
    int code;
    String msg;

    BooksContext({this.data, this.code, this.msg});

    factory BooksContext.fromJson(Map<String, dynamic> json) {
        return BooksContext(
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
    DataX data;
    int count;

    Data({this.data, this.count});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            data: json['data'] != null ? DataX.fromJson(json['data']) : null, 
            count: json['count'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class DataX {
    String chapterId;
    List<String> content;
    int creationTime;
    String fictionId;
    int fictionVariableId;
    int id;

    DataX({this.chapterId, this.content, this.creationTime, this.fictionId, this.fictionVariableId, this.id});

    factory DataX.fromJson(Map<String, dynamic> json) {
        return DataX(
            chapterId: json['chapterId'], 
            content: json['content'] != null ? new List<String>.from(json['content']) : null, 
            creationTime: json['creationTime'], 
            fictionId: json['fictionId'], 
            fictionVariableId: json['fictionVariableId'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chapterId'] = this.chapterId;
        data['creationTime'] = this.creationTime;
        data['fictionId'] = this.fictionId;
        data['fictionVariableId'] = this.fictionVariableId;
        data['id'] = this.id;
        if (this.content != null) {
            data['content'] = this.content;
        }
        return data;
    }
}