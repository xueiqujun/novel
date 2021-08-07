class TypeSearchJson {
    List<Book> books;
    bool ok;
    var total;

    TypeSearchJson({this.books, this.ok, this.total});

    factory TypeSearchJson.fromJson(Map<String, dynamic> json) {
        return TypeSearchJson(
            books: json['books'] != null ? (json['books'] as List).map((i) => Book.fromJson(i)).toList() : null,
            ok: json['ok'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        data['total'] = this.total;
        if (this.books != null) {
            data['books'] = this.books.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Book {
    String id;
    bool allowMonthly;
    String author;
    var banned;
    String contentType;
    String cover;
    String lastChapter;
    var latelyFollower;
    String majorCate;
    String minorCate;
    var retentionRatio;
    String shortIntro;
    String site;
    var sizetype;
    String superscript;
    List<String> tags;
    String title;

    Book({this.id, this.allowMonthly, this.author, this.banned, this.contentType, this.cover, this.lastChapter, this.latelyFollower, this.majorCate, this.minorCate, this.retentionRatio, this.shortIntro, this.site, this.sizetype, this.superscript, this.tags, this.title});

    factory Book.fromJson(Map<String, dynamic> json) {
        return Book(
            id: json['_id'],
            allowMonthly: json['allowMonthly'],
            author: json['author'],
            banned: json['banned'],
            contentType: json['contentType'],
            cover: json['cover'],
            lastChapter: json['lastChapter'],
            latelyFollower: json['latelyFollower'],
            majorCate: json['majorCate'],
            minorCate: json['minorCate'],
            retentionRatio: json['retentionRatio'],
            shortIntro: json['shortIntro'],
            site: json['site'],
            sizetype: json['sizetype'],
            superscript: json['superscript'],
            tags: json['tags'] != null ? new List<String>.from(json['tags']) : null,
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['allowMonthly'] = this.allowMonthly;
        data['author'] = this.author;
        data['banned'] = this.banned;
        data['contentType'] = this.contentType;
        data['cover'] = this.cover;
        data['lastChapter'] = this.lastChapter;
        data['latelyFollower'] = this.latelyFollower;
        data['majorCate'] = this.majorCate;
        data['minorCate'] = this.minorCate;
        data['retentionRatio'] = this.retentionRatio;
        data['shortIntro'] = this.shortIntro;
        data['site'] = this.site;
        data['sizetype'] = this.sizetype;
        data['superscript'] = this.superscript;
        data['title'] = this.title;
        if (this.tags != null) {
            data['tags'] = this.tags;
        }
        return data;
    }
}