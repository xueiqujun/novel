class searchType {
    List<Female> female;
    List<Male> male;
    bool ok;
    List<Picture> picture;
    List<Pres> press;

    searchType({this.female, this.male, this.ok, this.picture, this.press});

    factory searchType.fromJson(Map<String, dynamic> json) {
        return searchType(
            female: json['female'] != null ? (json['female'] as List).map((i) => Female.fromJson(i)).toList() : null,
            male: json['male'] != null ? (json['male'] as List).map((i) => Male.fromJson(i)).toList() : null,
            ok: json['ok'],
            picture: json['picture'] != null ? (json['picture'] as List).map((i) => Picture.fromJson(i)).toList() : null,
            press: json['press'] != null ? (json['press'] as List).map((i) => Pres.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        if (this.female != null) {
            data['female'] = this.female.map((v) => v.toJson()).toList();
        }
        if (this.male != null) {
            data['male'] = this.male.map((v) => v.toJson()).toList();
        }
        if (this.picture != null) {
            data['picture'] = this.picture.map((v) => v.toJson()).toList();
        }
        if (this.press != null) {
            data['press'] = this.press.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Female {
    int bookCount;
    List<String> bookCover;
    String icon;
    int monthlyCount;
    String name;

    Female({this.bookCount, this.bookCover, this.icon, this.monthlyCount, this.name});

    factory Female.fromJson(Map<String, dynamic> json) {
        return Female(
            bookCount: json['bookCount'],
            bookCover: json['bookCover'] != null ? new List<String>.from(json['bookCover']) : null,
            icon: json['icon'],
            monthlyCount: json['monthlyCount'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bookCount'] = this.bookCount;
        data['icon'] = this.icon;
        data['monthlyCount'] = this.monthlyCount;
        data['name'] = this.name;
        if (this.bookCover != null) {
            data['bookCover'] = this.bookCover;
        }
        return data;
    }
}

class Male {
    int bookCount;
    List<String> bookCover;
    String icon;
    int monthlyCount;
    String name;

    Male({this.bookCount, this.bookCover, this.icon, this.monthlyCount, this.name});

    factory Male.fromJson(Map<String, dynamic> json) {
        return Male(
            bookCount: json['bookCount'],
            bookCover: json['bookCover'] != null ? new List<String>.from(json['bookCover']) : null,
            icon: json['icon'],
            monthlyCount: json['monthlyCount'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bookCount'] = this.bookCount;
        data['icon'] = this.icon;
        data['monthlyCount'] = this.monthlyCount;
        data['name'] = this.name;
        if (this.bookCover != null) {
            data['bookCover'] = this.bookCover;
        }
        return data;
    }
}

class Picture {
    int bookCount;
    List<String> bookCover;
    String icon;
    int monthlyCount;
    String name;

    Picture({this.bookCount, this.bookCover, this.icon, this.monthlyCount, this.name});

    factory Picture.fromJson(Map<String, dynamic> json) {
        return Picture(
            bookCount: json['bookCount'],
            bookCover: json['bookCover'] != null ? new List<String>.from(json['bookCover']) : null,
            icon: json['icon'],
            monthlyCount: json['monthlyCount'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bookCount'] = this.bookCount;
        data['icon'] = this.icon;
        data['monthlyCount'] = this.monthlyCount;
        data['name'] = this.name;
        if (this.bookCover != null) {
            data['bookCover'] = this.bookCover;
        }
        return data;
    }
}

class Pres {
    int bookCount;
    List<String> bookCover;
    String icon;
    int monthlyCount;
    String name;

    Pres({this.bookCount, this.bookCover, this.icon, this.monthlyCount, this.name});

    factory Pres.fromJson(Map<String, dynamic> json) {
        return Pres(
            bookCount: json['bookCount'],
            bookCover: json['bookCover'] != null ? new List<String>.from(json['bookCover']) : null,
            icon: json['icon'],
            monthlyCount: json['monthlyCount'],
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bookCount'] = this.bookCount;
        data['icon'] = this.icon;
        data['monthlyCount'] = this.monthlyCount;
        data['name'] = this.name;
        if (this.bookCover != null) {
            data['bookCover'] = this.bookCover;
        }
        return data;
    }
}