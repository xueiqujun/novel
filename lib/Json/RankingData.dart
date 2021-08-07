class RankingDate {
    bool ok;
    Ranking ranking;

    RankingDate({this.ok, this.ranking});

    factory RankingDate.fromJson(Map<String, dynamic> json) {
        return RankingDate(
            ok: json['ok'],
            ranking: json['ranking'] != null ? Ranking.fromJson(json['ranking']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        if (this.ranking != null) {
            data['ranking'] = this.ranking.toJson();
        }
        return data;
    }
}

class Ranking {
    int v;
    String sid;
    String biTag;
    List<Book> books;
    bool collapse;
    String cover;
    String created;
    String gender;
    String icon;
    String id;
    bool isSub;
    String monthRank;
    bool ISnew;
    int priority;
    String shortTitle;
    String tag;
    String title;
    int total;
    String totalRank;
    String updated;

    Ranking({this.v, this.sid, this.biTag, this.books, this.collapse, this.cover, this.created, this.gender, this.icon, this.id, this.isSub, this.monthRank, this.ISnew, this.priority, this.shortTitle, this.tag, this.title, this.total, this.totalRank, this.updated});

    factory Ranking.fromJson(Map<String, dynamic> json) {
        return Ranking(
            v: json['__v'],
            sid: json['_id'],
            biTag: json['biTag'],
            books: json['books'] != null ? (json['books'] as List).map((i) => Book.fromJson(i)).toList() : null,
            collapse: json['collapse'],
            cover: json['cover'],
            created: json['created'],
            gender: json['gender'],
            icon: json['icon'],
            id: json['id'],
            isSub: json['isSub'],
            monthRank: json['monthRank'],
            ISnew: json['new'],
            priority: json['priority'],
            shortTitle: json['shortTitle'],
            tag: json['tag'],
            title: json['title'],
            total: json['total'],
            totalRank: json['totalRank'],
            updated: json['updated'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.sid;
        data['biTag'] = this.biTag;
        data['collapse'] = this.collapse;
        data['cover'] = this.cover;
        data['created'] = this.created;
        data['gender'] = this.gender;
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['isSub'] = this.isSub;
        data['monthRank'] = this.monthRank;
        data['new'] = this.ISnew;
        data['priority'] = this.priority;
        data['shortTitle'] = this.shortTitle;
        data['tag'] = this.tag;
        data['title'] = this.title;
        data['total'] = this.total;
        data['totalRank'] = this.totalRank;
        data['updated'] = this.updated;
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
    int banned;
    String cover;
    int latelyFollower;
    String majorCate;
    String minorCate;
    String retentionRatio;
    String shortIntro;
    String site;
    String title;

    Book({this.id, this.allowMonthly, this.author, this.banned, this.cover, this.latelyFollower, this.majorCate, this.minorCate, this.retentionRatio, this.shortIntro, this.site, this.title});

    factory Book.fromJson(Map<String, dynamic> json) {
        return Book(
            id: json['_id'],
            allowMonthly: json['allowMonthly'],
            author: json['author'],
            banned: json['banned'],
            cover: json['cover'],
            latelyFollower: json['latelyFollower'],
            majorCate: json['majorCate'],
            minorCate: json['minorCate'],
            retentionRatio: json['retentionRatio'],
            shortIntro: json['shortIntro'],
            site: json['site'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['allowMonthly'] = this.allowMonthly;
        data['author'] = this.author;
        data['banned'] = this.banned;
        data['cover'] = this.cover;
        data['latelyFollower'] = this.latelyFollower;
        data['majorCate'] = this.majorCate;
        data['minorCate'] = this.minorCate;
        data['retentionRatio'] = this.retentionRatio;
        data['shortIntro'] = this.shortIntro;
        data['site'] = this.site;
        data['title'] = this.title;
        return data;
    }
}