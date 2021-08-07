class qltjJson {
    List<Book> books;
    bool ok;
    int total;

    qltjJson({this.books, this.ok, this.total});

    factory qltjJson.fromJson(Map<String, dynamic> json) {
        return qltjJson(
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
    String aliases;
    bool allowMonthly;
    String author;
    int banned;
    String cat;
    String contentType;
    String cover;
    bool hasCp;
    Highlight highlight;
    String lastChapter;
    int latelyFollower;
    double retentionRatio;
    String shortIntro;
    String site;
    int sizetype;
    String superscript;
    String title;
    int wordCount;

    Book({this.id, this.aliases, this.allowMonthly, this.author, this.banned, this.cat, this.contentType, this.cover, this.hasCp, this.highlight, this.lastChapter, this.latelyFollower, this.retentionRatio, this.shortIntro, this.site, this.sizetype, this.superscript, this.title, this.wordCount});

    factory Book.fromJson(Map<String, dynamic> json) {
        return Book(
            id: json['_id'],
            aliases: json['aliases'],
            allowMonthly: json['allowMonthly'],
            author: json['author'],
            banned: json['banned'],
            cat: json['cat'],
            contentType: json['contentType'],
            cover: json['cover'],
            hasCp: json['hasCp'],
            highlight: json['highlight'] != null ? Highlight.fromJson(json['highlight']) : null,
            lastChapter: json['lastChapter'],
            latelyFollower: json['latelyFollower'],
            retentionRatio: json['retentionRatio'],
            shortIntro: json['shortIntro'],
            site: json['site'],
            sizetype: json['sizetype'],
            superscript: json['superscript'],
            title: json['title'],
            wordCount: json['wordCount'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['aliases'] = this.aliases;
        data['allowMonthly'] = this.allowMonthly;
        data['author'] = this.author;
        data['banned'] = this.banned;
        data['cat'] = this.cat;
        data['contentType'] = this.contentType;
        data['cover'] = this.cover;
        data['hasCp'] = this.hasCp;
        data['lastChapter'] = this.lastChapter;
        data['latelyFollower'] = this.latelyFollower;
        data['retentionRatio'] = this.retentionRatio;
        data['shortIntro'] = this.shortIntro;
        data['site'] = this.site;
        data['sizetype'] = this.sizetype;
        data['superscript'] = this.superscript;
        data['title'] = this.title;
        data['wordCount'] = this.wordCount;
        if (this.highlight != null) {
            data['highlight'] = this.highlight.toJson();
        }
        return data;
    }
}

class Highlight {
    List<String> title;

    Highlight({this.title});

    factory Highlight.fromJson(Map<String, dynamic> json) {
        return Highlight(
            title: json['title'] != null ? new List<String>.from(json['title']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.title != null) {
            data['title'] = this.title;
        }
        return data;
    }
}