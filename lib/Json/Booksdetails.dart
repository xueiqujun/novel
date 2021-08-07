class BooksDetailsJson{
    bool gg;
    String id;
    bool le;
    bool advertRead;
    bool allowBeanVoucher;
    bool allowFree;
    bool allowMonthly;
    bool allowVoucher;
    List<Object> anchors;
    String author;
    String authorDesc;
    int banned;
    BookVideos bookVideos;
    int buytype;
    String cat;
    int chaptersCount;
    int contentLevel;
    String contentType;
    String copyright;
    String copyrightDesc;
    String copyrightInfo;
    String cover;
    String creater;
    int currency;
    Object discount;
    bool donate;
    String enSource;
    int followerCount;
    List<String> gender;
    bool hasCopyright;
    bool hasCp;
    bool isAllowNetSearch;
    bool isBigVip;
    bool isFineBook;
    bool isForbidForFreeApp;
    bool isMakeMoneyLimit;
    bool isSerial;
    String lastChapter;
    int latelyFollower;
    int latelyFollowerBase;
    bool limit;
    String longIntro;
    String majorCate;
    String majorCateV2;

    String minorCate;
    String minorCateV2;
    String originalAuthor;
    int postCount;
    Rating rating;

    int safelevel;
    int serializeWordCount;
    int sizetype;
    int starRatingCount;
    List<StarRating> starRatings;
    String superscript;
    List<Object> tags;
    String title;
    int totalFollower;
    String updated;
    int wordCount;

    BooksDetailsJson({this.gg, this.id, this.le, this.advertRead, this.allowBeanVoucher, this.allowFree, this.allowMonthly, this.allowVoucher, this.anchors, this.author, this.authorDesc, this.banned, this.bookVideos, this.buytype, this.cat, this.chaptersCount, this.contentLevel, this.contentType, this.copyright, this.copyrightDesc, this.copyrightInfo, this.cover, this.creater, this.currency, this.discount, this.donate, this.enSource, this.followerCount, this.gender, this.hasCopyright, this.hasCp, this.isAllowNetSearch, this.isBigVip, this.isFineBook, this.isForbidForFreeApp, this.isMakeMoneyLimit, this.isSerial, this.lastChapter, this.latelyFollower, this.latelyFollowerBase, this.limit, this.longIntro, this.majorCate, this.majorCateV2,  this.minorCate, this.minorCateV2, this.originalAuthor, this.postCount, this.rating,  this.safelevel, this.serializeWordCount, this.sizetype, this.starRatingCount, this.starRatings, this.superscript, this.tags, this.title, this.totalFollower, this.updated, this.wordCount});

    factory BooksDetailsJson.fromJson(Map<String, dynamic> json) {
        return BooksDetailsJson(
            gg: json['_gg'],
            id: json['_id'],
            le: json['_le'],
            advertRead: json['advertRead'],
            allowBeanVoucher: json['allowBeanVoucher'],
            allowFree: json['allowFree'],
            allowMonthly: json['allowMonthly'],
            allowVoucher: json['allowVoucher'],
            author: json['author'],
            authorDesc: json['authorDesc'],
            banned: json['banned'],
            bookVideos: json['bookVideos'] != null ? BookVideos.fromJson(json['bookVideos']) : null,
            buytype: json['buytype'],
            cat: json['cat'],
            chaptersCount: json['chaptersCount'],
            contentLevel: json['contentLevel'],
            contentType: json['contentType'],
            copyright: json['copyright'],
            copyrightDesc: json['copyrightDesc'],
            copyrightInfo: json['copyrightInfo'],
            cover: json['cover'],
            creater: json['creater'],
            currency: json['currency'],

            donate: json['donate'],
            enSource: json['enSource'],
            followerCount: json['followerCount'],
            gender: json['gender'] != null ? new List<String>.from(json['gender']) : null,
            hasCopyright: json['hasCopyright'],
            hasCp: json['hasCp'],
            isAllowNetSearch: json['isAllowNetSearch'],
            isBigVip: json['isBigVip'],
            isFineBook: json['isFineBook'],
            isForbidForFreeApp: json['isForbidForFreeApp'],
            isMakeMoneyLimit: json['isMakeMoneyLimit'],
            isSerial: json['isSerial'],
            lastChapter: json['lastChapter'],
            latelyFollower: json['latelyFollower'],
            latelyFollowerBase: json['latelyFollowerBase'],
            limit: json['limit'],
            longIntro: json['longIntro'],
            majorCate: json['majorCate'],
            majorCateV2: json['majorCateV2'],
            minorCate: json['minorCate'],
            minorCateV2: json['minorCateV2'],
            originalAuthor: json['originalAuthor'],
            postCount: json['postCount'],
            rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
            safelevel: json['safelevel'],
            serializeWordCount: json['serializeWordCount'],
            sizetype: json['sizetype'],
            starRatingCount: json['starRatingCount'],
            starRatings: json['starRatings'] != null ? (json['starRatings'] as List).map((i) => StarRating.fromJson(i)).toList() : null,
            superscript: json['superscript'],
            title: json['title'],
            totalFollower: json['totalFollower'],
            updated: json['updated'],
            wordCount: json['wordCount'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_gg'] = this.gg;
        data['_id'] = this.id;
        data['_le'] = this.le;
        data['advertRead'] = this.advertRead;
        data['allowBeanVoucher'] = this.allowBeanVoucher;
        data['allowFree'] = this.allowFree;
        data['allowMonthly'] = this.allowMonthly;
        data['allowVoucher'] = this.allowVoucher;
        data['author'] = this.author;
        data['authorDesc'] = this.authorDesc;
        data['banned'] = this.banned;
        data['buytype'] = this.buytype;
        data['cat'] = this.cat;
        data['chaptersCount'] = this.chaptersCount;
        data['contentLevel'] = this.contentLevel;
        data['contentType'] = this.contentType;
        data['copyright'] = this.copyright;
        data['copyrightDesc'] = this.copyrightDesc;
        data['copyrightInfo'] = this.copyrightInfo;
        data['cover'] = this.cover;
        data['creater'] = this.creater;
        data['currency'] = this.currency;
        data['donate'] = this.donate;
        data['enSource'] = this.enSource;
        data['followerCount'] = this.followerCount;
        data['hasCopyright'] = this.hasCopyright;
        data['hasCp'] = this.hasCp;
        data['isAllowNetSearch'] = this.isAllowNetSearch;
        data['isBigVip'] = this.isBigVip;
        data['isFineBook'] = this.isFineBook;
        data['isForbidForFreeApp'] = this.isForbidForFreeApp;
        data['isMakeMoneyLimit'] = this.isMakeMoneyLimit;
        data['isSerial'] = this.isSerial;
        data['lastChapter'] = this.lastChapter;
        data['latelyFollower'] = this.latelyFollower;
        data['latelyFollowerBase'] = this.latelyFollowerBase;
        data['limit'] = this.limit;
        data['longIntro'] = this.longIntro;
        data['majorCate'] = this.majorCate;
        data['majorCateV2'] = this.majorCateV2;
        data['minorCate'] = this.minorCate;
        data['minorCateV2'] = this.minorCateV2;
        data['originalAuthor'] = this.originalAuthor;
        data['postCount'] = this.postCount;
        data['safelevel'] = this.safelevel;
        data['serializeWordCount'] = this.serializeWordCount;
        data['sizetype'] = this.sizetype;
        data['starRatingCount'] = this.starRatingCount;
        data['superscript'] = this.superscript;
        data['title'] = this.title;
        data['totalFollower'] = this.totalFollower;
        data['updated'] = this.updated;
        data['wordCount'] = this.wordCount;

        if (this.bookVideos != null) {
            data['bookVideos'] = this.bookVideos.toJson();
        }

        if (this.gender != null) {
            data['gender'] = this.gender;
        }
        if (this.rating != null) {
            data['rating'] = this.rating.toJson();
        }
        if (this.starRatings != null) {
            data['starRatings'] = this.starRatings.map((v) => v.toJson()).toList();
        }

        return data;
    }
}

class BookVideos {
    String cover;
    List<Object> video;

    BookVideos({this.cover, this.video});

    factory BookVideos.fromJson(Map<String, dynamic> json) {
        return BookVideos(
            cover: json['cover'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cover'] = this.cover;

        return data;
    }
}

class StarRating {
    int count;
    int star;

    StarRating({this.count, this.star});

    factory StarRating.fromJson(Map<String, dynamic> json) {
        return StarRating(
            count: json['count'],
            star: json['star'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['star'] = this.star;
        return data;
    }
}

class Rating {
    int count;
    bool isEffect;
    var score;
    String tip;

    Rating({this.count, this.isEffect, this.score, this.tip});

    factory Rating.fromJson(Map<String, dynamic> json) {
        return Rating(
            count: json['count'],
            isEffect: json['isEffect'],
            score: json['score'],
            tip: json['tip'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['isEffect'] = this.isEffect;
        data['score'] = this.score;
        data['tip'] = this.tip;
        return data;
    }
}