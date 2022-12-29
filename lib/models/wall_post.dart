class WallPost {
  Response? response;

  WallPost({this.response});

  WallPost.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  int? count;
  List<Items>? items;

  Response({this.count, this.items});

  Response.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? fromId;
  int? ownerId;
  int? date;
  int? markedAsAds;
  bool? isFavorite;
  String? postType;
  String? text;
  int? isPinned;
  List<Attachments>? attachments;
  PostSource? postSource;
  Comments? comments;
  Likes? likes;
  Reposts? reposts;
  Views? views;
  Donut? donut;
  double? shortTextRate;
  int? carouselOffset;
  String? hash;
  int? edited;
  Copyright? copyright;

  Items(
      {this.id,
        this.fromId,
        this.ownerId,
        this.date,
        this.markedAsAds,
        this.isFavorite,
        this.postType,
        this.text,
        this.isPinned,
        this.attachments,
        this.postSource,
        this.comments,
        this.likes,
        this.reposts,
        this.views,
        this.donut,
        this.shortTextRate,
        this.carouselOffset,
        this.hash,
        this.edited,
        this.copyright});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    ownerId = json['owner_id'];
    date = json['date'];
    markedAsAds = json['marked_as_ads'];
    isFavorite = json['is_favorite'];
    postType = json['post_type'];
    text = json['text'];
    isPinned = json['is_pinned'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    postSource = json['post_source'] != null
        ? new PostSource.fromJson(json['post_source'])
        : null;
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
    likes = json['likes'] != null ? new Likes.fromJson(json['likes']) : null;
    reposts =
    json['reposts'] != null ? new Reposts.fromJson(json['reposts']) : null;
    views = json['views'] != null ? new Views.fromJson(json['views']) : null;
    donut = json['donut'] != null ? new Donut.fromJson(json['donut']) : null;
    shortTextRate = json['short_text_rate'];
    carouselOffset = json['carousel_offset'];
    hash = json['hash'];
    edited = json['edited'];
    copyright = json['copyright'] != null
        ? new Copyright.fromJson(json['copyright'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['owner_id'] = this.ownerId;
    data['date'] = this.date;
    data['marked_as_ads'] = this.markedAsAds;
    data['is_favorite'] = this.isFavorite;
    data['post_type'] = this.postType;
    data['text'] = this.text;
    data['is_pinned'] = this.isPinned;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.postSource != null) {
      data['post_source'] = this.postSource!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.toJson();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.toJson();
    }
    if (this.reposts != null) {
      data['reposts'] = this.reposts!.toJson();
    }
    if (this.views != null) {
      data['views'] = this.views!.toJson();
    }
    if (this.donut != null) {
      data['donut'] = this.donut!.toJson();
    }
    data['short_text_rate'] = this.shortTextRate;
    data['carousel_offset'] = this.carouselOffset;
    data['hash'] = this.hash;
    data['edited'] = this.edited;
    if (this.copyright != null) {
      data['copyright'] = this.copyright!.toJson();
    }
    return data;
  }
}

class Attachments {
  String? type;
  Photo? photo;
  Doc? doc;
  Album? album;
  Video? video;

  Attachments({this.type, this.photo, this.doc, this.album, this.video});

  Attachments.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    doc = json['doc'] != null ? new Doc.fromJson(json['doc']) : null;
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    if (this.doc != null) {
      data['doc'] = this.doc!.toJson();
    }
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}

class Photo {
  int? albumId;
  int? date;
  int? id;
  int? ownerId;
  String? accessKey;
  List<Sizes>? sizes;
  String? text;
  int? userId;
  bool? hasTags;
  int? postId;

  Photo(
      {this.albumId,
        this.date,
        this.id,
        this.ownerId,
        this.accessKey,
        this.sizes,
        this.text,
        this.userId,
        this.hasTags,
        this.postId});

  Photo.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    date = json['date'];
    id = json['id'];
    ownerId = json['owner_id'];
    accessKey = json['access_key'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
    text = json['text'];
    userId = json['user_id'];
    hasTags = json['has_tags'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_id'] = this.albumId;
    data['date'] = this.date;
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['access_key'] = this.accessKey;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['user_id'] = this.userId;
    data['has_tags'] = this.hasTags;
    data['post_id'] = this.postId;
    return data;
  }
}

class Sizes {
  int? height;
  String? type;
  int? width;
  String? url;

  Sizes({this.height, this.type, this.width, this.url});

  Sizes.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    type = json['type'];
    width = json['width'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['type'] = this.type;
    data['width'] = this.width;
    data['url'] = this.url;
    return data;
  }
}

class Doc {
  int? id;
  int? ownerId;
  String? title;
  int? size;
  String? ext;
  int? date;
  int? type;
  String? url;
  String? accessKey;

  Doc(
      {this.id,
        this.ownerId,
        this.title,
        this.size,
        this.ext,
        this.date,
        this.type,
        this.url,
        this.accessKey});

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    title = json['title'];
    size = json['size'];
    ext = json['ext'];
    date = json['date'];
    type = json['type'];
    url = json['url'];
    accessKey = json['access_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['title'] = this.title;
    data['size'] = this.size;
    data['ext'] = this.ext;
    data['date'] = this.date;
    data['type'] = this.type;
    data['url'] = this.url;
    data['access_key'] = this.accessKey;
    return data;
  }
}

class Album {
  int? created;
  int? id;
  int? ownerId;
  int? size;
  String? title;
  int? updated;
  String? description;
  Thumb? thumb;

  Album(
      {this.created,
        this.id,
        this.ownerId,
        this.size,
        this.title,
        this.updated,
        this.description,
        this.thumb});

  Album.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    id = json['id'];
    ownerId = json['owner_id'];
    size = json['size'];
    title = json['title'];
    updated = json['updated'];
    description = json['description'];
    thumb = json['thumb'] != null ? new Thumb.fromJson(json['thumb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['size'] = this.size;
    data['title'] = this.title;
    data['updated'] = this.updated;
    data['description'] = this.description;
    if (this.thumb != null) {
      data['thumb'] = this.thumb!.toJson();
    }
    return data;
  }
}

class Thumb {
  int? albumId;
  int? date;
  int? id;
  int? ownerId;
  String? accessKey;
  List<Sizes>? sizes;
  String? text;
  int? userId;
  bool? hasTags;

  Thumb(
      {this.albumId,
        this.date,
        this.id,
        this.ownerId,
        this.accessKey,
        this.sizes,
        this.text,
        this.userId,
        this.hasTags});

  Thumb.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    date = json['date'];
    id = json['id'];
    ownerId = json['owner_id'];
    accessKey = json['access_key'];
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
    text = json['text'];
    userId = json['user_id'];
    hasTags = json['has_tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_id'] = this.albumId;
    data['date'] = this.date;
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['access_key'] = this.accessKey;
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['user_id'] = this.userId;
    data['has_tags'] = this.hasTags;
    return data;
  }
}

class Video {
  String? accessKey;
  int? canComment;
  int? canLike;
  int? canRepost;
  int? canSubscribe;
  int? canAddToFaves;
  int? canAdd;
  int? comments;
  int? date;
  String? description;
  int? duration;
  List<Image>? image;
  List<FirstFrame>? firstFrame;
  int? width;
  int? height;
  int? id;
  int? ownerId;
  String? title;
  bool? isFavorite;
  String? trackCode;
  int? repeat;
  String? type;
  int? views;

  Video(
      {this.accessKey,
        this.canComment,
        this.canLike,
        this.canRepost,
        this.canSubscribe,
        this.canAddToFaves,
        this.canAdd,
        this.comments,
        this.date,
        this.description,
        this.duration,
        this.image,
        this.firstFrame,
        this.width,
        this.height,
        this.id,
        this.ownerId,
        this.title,
        this.isFavorite,
        this.trackCode,
        this.repeat,
        this.type,
        this.views});

  Video.fromJson(Map<String, dynamic> json) {
    accessKey = json['access_key'];
    canComment = json['can_comment'];
    canLike = json['can_like'];
    canRepost = json['can_repost'];
    canSubscribe = json['can_subscribe'];
    canAddToFaves = json['can_add_to_faves'];
    canAdd = json['can_add'];
    comments = json['comments'];
    date = json['date'];
    description = json['description'];
    duration = json['duration'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    if (json['first_frame'] != null) {
      firstFrame = <FirstFrame>[];
      json['first_frame'].forEach((v) {
        firstFrame!.add(new FirstFrame.fromJson(v));
      });
    }
    width = json['width'];
    height = json['height'];
    id = json['id'];
    ownerId = json['owner_id'];
    title = json['title'];
    isFavorite = json['is_favorite'];
    trackCode = json['track_code'];
    repeat = json['repeat'];
    type = json['type'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_key'] = this.accessKey;
    data['can_comment'] = this.canComment;
    data['can_like'] = this.canLike;
    data['can_repost'] = this.canRepost;
    data['can_subscribe'] = this.canSubscribe;
    data['can_add_to_faves'] = this.canAddToFaves;
    data['can_add'] = this.canAdd;
    data['comments'] = this.comments;
    data['date'] = this.date;
    data['description'] = this.description;
    data['duration'] = this.duration;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.firstFrame != null) {
      data['first_frame'] = this.firstFrame!.map((v) => v.toJson()).toList();
    }
    data['width'] = this.width;
    data['height'] = this.height;
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['title'] = this.title;
    data['is_favorite'] = this.isFavorite;
    data['track_code'] = this.trackCode;
    data['repeat'] = this.repeat;
    data['type'] = this.type;
    data['views'] = this.views;
    return data;
  }
}

class Image {
  String? url;
  int? width;
  int? height;
  int? withPadding;

  Image({this.url, this.width, this.height, this.withPadding});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    withPadding = json['with_padding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['with_padding'] = this.withPadding;
    return data;
  }
}

class FirstFrame {
  String? url;
  int? width;
  int? height;

  FirstFrame({this.url, this.width, this.height});

  FirstFrame.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class PostSource {
  String? type;
  String? platform;

  PostSource({this.type, this.platform});

  PostSource.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['platform'] = this.platform;
    return data;
  }
}

class Comments {
  int? canPost;
  int? count;
  bool? groupsCanPost;

  Comments({this.canPost, this.count, this.groupsCanPost});

  Comments.fromJson(Map<String, dynamic> json) {
    canPost = json['can_post'];
    count = json['count'];
    groupsCanPost = json['groups_can_post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['can_post'] = this.canPost;
    data['count'] = this.count;
    data['groups_can_post'] = this.groupsCanPost;
    return data;
  }
}

class Likes {
  int? canLike;
  int? count;
  int? userLikes;
  int? canPublish;

  Likes({this.canLike, this.count, this.userLikes, this.canPublish});

  Likes.fromJson(Map<String, dynamic> json) {
    canLike = json['can_like'];
    count = json['count'];
    userLikes = json['user_likes'];
    canPublish = json['can_publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['can_like'] = this.canLike;
    data['count'] = this.count;
    data['user_likes'] = this.userLikes;
    data['can_publish'] = this.canPublish;
    return data;
  }
}

class Reposts {
  int? count;
  int? userReposted;

  Reposts({this.count, this.userReposted});

  Reposts.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    userReposted = json['user_reposted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['user_reposted'] = this.userReposted;
    return data;
  }
}

class Views {
  int? count;

  Views({this.count});

  Views.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class Donut {
  bool? isDonut;

  Donut({this.isDonut});

  Donut.fromJson(Map<String, dynamic> json) {
    isDonut = json['is_donut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_donut'] = this.isDonut;
    return data;
  }
}

class Copyright {
  int? id;
  String? link;
  String? type;
  String? name;

  Copyright({this.id, this.link, this.type, this.name});

  Copyright.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}
