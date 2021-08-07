class NovelInfo {
    List<Data> data;
    String code;
    String msg;

    NovelInfo({this.data, this.code, this.msg});

    factory NovelInfo.fromJson(Map<String, dynamic> json) {
        return NovelInfo(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
            code: json['code'],
            msg: json['msg'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['msg'] = this.msg;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    String author;
    String book_cover;
    String book_id;
    String introduction;
    String name;

    Data({this.author, this.book_cover, this.book_id, this.introduction, this.name});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            author: json['author'],
            book_cover: json['book_cover'],
            book_id: json['book_id'],
            introduction: json['introduction'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['book_cover'] = this.book_cover;
        data['book_id'] = this.book_id;
        data['introduction'] = this.introduction;
        data['name'] = this.name;
        return data;
    }
}