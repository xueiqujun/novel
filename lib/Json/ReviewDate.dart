class ReviewDate {
    bool ok;
    List<Review> reviews;
    int today;
    int total;

    ReviewDate({this.ok, this.reviews, this.today, this.total});

    factory ReviewDate.fromJson(Map<String, dynamic> json) {
        return ReviewDate(
            ok: json['ok'],
            reviews: json['reviews'] != null ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList() : null,
            today: json['today'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        data['today'] = this.today;
        data['total'] = this.total;
        if (this.reviews != null) {
            data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Review {
    String id;
    Author author;
    int commentCount;
    String content;
    String created;
    Helpful helpful;
    int likeCount;
    int rating;
    String state;
    String title;
    String updated;

    Review({this.id, this.author, this.commentCount, this.content, this.created, this.helpful, this.likeCount, this.rating, this.state, this.title, this.updated});

    factory Review.fromJson(Map<String, dynamic> json) {
        return Review(
            id: json['_id'],
            author: json['author'] != null ? Author.fromJson(json['author']) : null,
            commentCount: json['commentCount'],
            content: json['content'],
            created: json['created'],
            helpful: json['helpful'] != null ? Helpful.fromJson(json['helpful']) : null,
            likeCount: json['likeCount'],
            rating: json['rating'],
            state: json['state'],
            title: json['title'],
            updated: json['updated'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['commentCount'] = this.commentCount;
        data['content'] = this.content;
        data['created'] = this.created;
        data['likeCount'] = this.likeCount;
        data['rating'] = this.rating;
        data['state'] = this.state;
        data['title'] = this.title;
        data['updated'] = this.updated;
        if (this.author != null) {
            data['author'] = this.author.toJson();
        }
        if (this.helpful != null) {
            data['helpful'] = this.helpful.toJson();
        }
        return data;
    }
}

class Helpful {
    int no;
    int total;
    int yes;

    Helpful({this.no, this.total, this.yes});

    factory Helpful.fromJson(Map<String, dynamic> json) {
        return Helpful(
            no: json['no'],
            total: json['total'],
            yes: json['yes'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['no'] = this.no;
        data['total'] = this.total;
        data['yes'] = this.yes;
        return data;
    }
}

class Author {
    String id;
    String activityAvatar;
    String avatar;
    String gender;
    int lv;
    String nickname;
    String type;

    Author({this.id, this.activityAvatar, this.avatar, this.gender, this.lv, this.nickname, this.type});

    factory Author.fromJson(Map<String, dynamic> json) {
        return Author(
            id: json['_id'],
            activityAvatar: json['activityAvatar'],
            avatar: json['avatar'],
            gender: json['gender'],
            lv: json['lv'],
            nickname: json['nickname'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['activityAvatar'] = this.activityAvatar;
        data['avatar'] = this.avatar;
        data['gender'] = this.gender;
        data['lv'] = this.lv;
        data['nickname'] = this.nickname;
        data['type'] = this.type;
        return data;
    }
}