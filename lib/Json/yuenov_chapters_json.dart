class YuenovChaptersJson {
    Data data;
    Result result;

    YuenovChaptersJson({this.data, this.result});

    factory YuenovChaptersJson.fromJson(Map<String, dynamic> json) {
        return YuenovChaptersJson(
            data: json['data'] != null ? Data.fromJson(json['data']) : null, 
            result: json['result'] != null ? Result.fromJson(json['result']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        if (this.result != null) {
            data['result'] = this.result.toJson();
        }
        return data;
    }
}

class Result {
    int code;
    String msg;

    Result({this.code, this.msg});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            code: json['code'], 
            msg: json['msg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['msg'] = this.msg;
        return data;
    }
}

class Data {
    String author;
    int bookId;
    List<Chapter> chapters;
    String coverImg;
    String desc;
    String title;
    String word;

    Data({this.author, this.bookId, this.chapters, this.coverImg, this.desc, this.title, this.word});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            author: json['author'], 
            bookId: json['bookId'], 
            chapters: json['chapters'] != null ? (json['chapters'] as List).map((i) => Chapter.fromJson(i)).toList() : null, 
            coverImg: json['coverImg'], 
            desc: json['desc'], 
            title: json['title'], 
            word: json['word'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['bookId'] = this.bookId;
        data['coverImg'] = this.coverImg;
        data['desc'] = this.desc;
        data['title'] = this.title;
        data['word'] = this.word;
        if (this.chapters != null) {
            data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Chapter {
    int id;
    String name;
    int v;

    Chapter({this.id, this.name, this.v});

    factory Chapter.fromJson(Map<String, dynamic> json) {
        return Chapter(
            id: json['id'], 
            name: json['name'], 
            v: json['v'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['v'] = this.v;
        return data;
    }
}