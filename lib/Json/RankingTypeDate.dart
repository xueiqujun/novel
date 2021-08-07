class RakingDataType {
    List<Epub> epub;
    List<Female> female;
    List<Male> male;
    bool ok;
    List<Picture> picture;

    RakingDataType({this.epub, this.female, this.male, this.ok, this.picture});

    factory RakingDataType.fromJson(Map<String, dynamic> json) {
        return RakingDataType(
            epub: json['epub'] != null ? (json['epub'] as List).map((i) => Epub.fromJson(i)).toList() : null,
            female: json['female'] != null ? (json['female'] as List).map((i) => Female.fromJson(i)).toList() : null,
            male: json['male'] != null ? (json['male'] as List).map((i) => Male.fromJson(i)).toList() : null,
            ok: json['ok'],
            picture: json['picture'] != null ? (json['picture'] as List).map((i) => Picture.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ok'] = this.ok;
        if (this.epub != null) {
            data['epub'] = this.epub.map((v) => v.toJson()).toList();
        }
        if (this.female != null) {
            data['female'] = this.female.map((v) => v.toJson()).toList();
        }
        if (this.male != null) {
            data['male'] = this.male.map((v) => v.toJson()).toList();
        }
        if (this.picture != null) {
            data['picture'] = this.picture.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Epub {
    String id;
    bool collapse;
    String cover;
    String shortTitle;
    String title;

    Epub({this.id, this.collapse, this.cover, this.shortTitle, this.title});

    factory Epub.fromJson(Map<String, dynamic> json) {
        return Epub(
            id: json['_id'],
            collapse: json['collapse'],
            cover: json['cover'],
            shortTitle: json['shortTitle'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['collapse'] = this.collapse;
        data['cover'] = this.cover;
        data['shortTitle'] = this.shortTitle;
        data['title'] = this.title;
        return data;
    }
}

class Male {
    String id;
    bool collapse;
    String cover;
    String monthRank;
    String shortTitle;
    String title;
    String totalRank;

    Male({this.id, this.collapse, this.cover, this.monthRank, this.shortTitle, this.title, this.totalRank});

    factory Male.fromJson(Map<String, dynamic> json) {
        return Male(
            id: json['_id'],
            collapse: json['collapse'],
            cover: json['cover'],
            monthRank: json['monthRank'],
            shortTitle: json['shortTitle'],
            title: json['title'],
            totalRank: json['totalRank'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['collapse'] = this.collapse;
        data['cover'] = this.cover;
        data['monthRank'] = this.monthRank;
        data['shortTitle'] = this.shortTitle;
        data['title'] = this.title;
        data['totalRank'] = this.totalRank;
        return data;
    }
}

class Female {
    String id;
    bool collapse;
    String cover;
    String monthRank;
    String shortTitle;
    String title;
    String totalRank;

    Female({this.id, this.collapse, this.cover, this.monthRank, this.shortTitle, this.title, this.totalRank});

    factory Female.fromJson(Map<String, dynamic> json) {
        return Female(
            id: json['_id'],
            collapse: json['collapse'],
            cover: json['cover'],
            monthRank: json['monthRank'],
            shortTitle: json['shortTitle'],
            title: json['title'],
            totalRank: json['totalRank'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['collapse'] = this.collapse;
        data['cover'] = this.cover;
        data['monthRank'] = this.monthRank;
        data['shortTitle'] = this.shortTitle;
        data['title'] = this.title;
        data['totalRank'] = this.totalRank;
        return data;
    }
}

class Picture {
    String id;
    bool collapse;
    String cover;
    String shortTitle;
    String title;

    Picture({this.id, this.collapse, this.cover, this.shortTitle, this.title});

    factory Picture.fromJson(Map<String, dynamic> json) {
        return Picture(
            id: json['_id'],
            collapse: json['collapse'],
            cover: json['cover'],
            shortTitle: json['shortTitle'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['collapse'] = this.collapse;
        data['cover'] = this.cover;
        data['shortTitle'] = this.shortTitle;
        data['title'] = this.title;
        return data;
    }
}