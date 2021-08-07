class YuenovDetailsJson {
    Data data;
    Result result;

    YuenovDetailsJson({this.data, this.result});

    factory YuenovDetailsJson.fromJson(Map<String, dynamic> json) {
        return YuenovDetailsJson(
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
    String categoryName;
    int chapterNum;
    String coverImg;
    String desc;
    List<Recommend> recommend;
    String title;
    Update update;
    String word;

    Data({this.author, this.bookId, this.categoryName, this.chapterNum, this.coverImg, this.desc, this.recommend, this.title, this.update, this.word});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            author: json['author'], 
            bookId: json['bookId'], 
            categoryName: json['categoryName'], 
            chapterNum: json['chapterNum'], 
            coverImg: json['coverImg'], 
            desc: json['desc'], 
            recommend: json['recommend'] != null ? (json['recommend'] as List).map((i) => Recommend.fromJson(i)).toList() : null, 
            title: json['title'], 
            update: json['update'] != null ? Update.fromJson(json['update']) : null, 
            word: json['word'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['bookId'] = this.bookId;
        data['categoryName'] = this.categoryName;
        data['chapterNum'] = this.chapterNum;
        data['coverImg'] = this.coverImg;
        data['desc'] = this.desc;
        data['title'] = this.title;
        data['word'] = this.word;
        if (this.recommend != null) {
            data['recommend'] = this.recommend.map((v) => v.toJson()).toList();
        }
        if (this.update != null) {
            data['update'] = this.update.toJson();
        }
        return data;
    }
}

class Recommend {
    String author;
    int bookId;
    String categoryName;
    String chapterStatus;
    String coverImg;
    String desc;
    String title;
    String word;

    Recommend({this.author, this.bookId, this.categoryName, this.chapterStatus, this.coverImg, this.desc, this.title, this.word});

    factory Recommend.fromJson(Map<String, dynamic> json) {
        return Recommend(
            author: json['author'], 
            bookId: json['bookId'], 
            categoryName: json['categoryName'], 
            chapterStatus: json['chapterStatus'], 
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
        data['categoryName'] = this.categoryName;
        data['chapterStatus'] = this.chapterStatus;
        data['coverImg'] = this.coverImg;
        data['desc'] = this.desc;
        data['title'] = this.title;
        data['word'] = this.word;
        return data;
    }
}

class Update {
    int chapterId;
    String chapterName;
    String chapterStatus;
    int time;

    Update({this.chapterId, this.chapterName, this.chapterStatus, this.time});

    factory Update.fromJson(Map<String, dynamic> json) {
        return Update(
            chapterId: json['chapterId'], 
            chapterName: json['chapterName'], 
            chapterStatus: json['chapterStatus'], 
            time: json['time'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chapterId'] = this.chapterId;
        data['chapterName'] = this.chapterName;
        data['chapterStatus'] = this.chapterStatus;
        data['time'] = this.time;
        return data;
    }
}