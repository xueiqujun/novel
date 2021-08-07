class Backinfo {
    List<Data> data;
    String code;
    String msg;

    Backinfo({this.data, this.code, this.msg});

    factory Backinfo.fromJson(Map<String, dynamic> json) {
        return Backinfo(
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
    String book_id;
    String image_url;
    String name;

    Data({this.author, this.book_id, this.image_url, this.name});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            author: json['author'], 
            book_id: json['book_id'], 
            image_url: json['image_url'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['book_id'] = this.book_id;
        data['image_url'] = this.image_url;
        data['name'] = this.name;
        return data;
    }
}