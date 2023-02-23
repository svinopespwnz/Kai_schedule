class WallPost {
  Response? response;

  WallPost({this.response});

  WallPost.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ?  Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
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
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
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
        attachments!.add(Attachments.fromJson(v));
      });
    }
    postSource = json['post_source'] != null
        ? PostSource.fromJson(json['post_source'])
        : null;
    comments = json['comments'] != null
        ? Comments.fromJson(json['comments'])
        : null;
    likes = json['likes'] != null ? Likes.fromJson(json['likes']) : null;
    reposts =
    json['reposts'] != null ? Reposts.fromJson(json['reposts']) : null;
    views = json['views'] != null ? Views.fromJson(json['views']) : null;
    donut = json['donut'] != null ? Donut.fromJson(json['donut']) : null;
    shortTextRate = json['short_text_rate'];
    carouselOffset = json['carousel_offset'];
    hash = json['hash'];
    edited = json['edited'];
    copyright = json['copyright'] != null
        ? Copyright.fromJson(json['copyright'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['owner_id'] = ownerId;
    data['date'] = date;
    data['marked_as_ads'] = markedAsAds;
    data['is_favorite'] = isFavorite;
    data['post_type'] = postType;
    data['text'] = text;
    data['is_pinned'] = isPinned;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    if (postSource != null) {
      data['post_source'] = postSource!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    if (likes != null) {
      data['likes'] = likes!.toJson();
    }
    if (reposts != null) {
      data['reposts'] = reposts!.toJson();
    }
    if (views != null) {
      data['views'] = views!.toJson();
    }
    if (donut != null) {
      data['donut'] = donut!.toJson();
    }
    data['short_text_rate'] = shortTextRate;
    data['carousel_offset'] = carouselOffset;
    data['hash'] = hash;
    data['edited'] = edited;
    if (copyright != null) {
      data['copyright'] = copyright!.toJson();
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
    photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;
    doc = json['doc'] != null ? Doc.fromJson(json['doc']) : null;
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    if (doc != null) {
      data['doc'] = doc!.toJson();
    }
    if (album != null) {
      data['album'] = album!.toJson();
    }
    if (video != null) {
      data['video'] = video!.toJson();
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
        sizes!.add(Sizes.fromJson(v));
      });
    }
    text = json['text'];
    userId = json['user_id'];
    hasTags = json['has_tags'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_id'] = albumId;
    data['date'] = date;
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['access_key'] = accessKey;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['text'] = text;
    data['user_id'] = userId;
    data['has_tags'] = hasTags;
    data['post_id'] = postId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['type'] = type;
    data['width'] = width;
    data['url'] = url;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['title'] = title;
    data['size'] = size;
    data['ext'] = ext;
    data['date'] = date;
    data['type'] = type;
    data['url'] = url;
    data['access_key'] = accessKey;
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
    thumb = json['thumb'] != null ? Thumb.fromJson(json['thumb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created'] = created;
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['size'] = size;
    data['title'] = title;
    data['updated'] = updated;
    data['description'] = description;
    if (thumb != null) {
      data['thumb'] = thumb!.toJson();
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
        sizes!.add(Sizes.fromJson(v));
      });
    }
    text = json['text'];
    userId = json['user_id'];
    hasTags = json['has_tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_id'] = albumId;
    data['date'] = date;
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['access_key'] = accessKey;
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    data['text'] = text;
    data['user_id'] = userId;
    data['has_tags'] = hasTags;
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
        image!.add(Image.fromJson(v));
      });
    }
    if (json['first_frame'] != null) {
      firstFrame = <FirstFrame>[];
      json['first_frame'].forEach((v) {
        firstFrame!.add(FirstFrame.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_key'] = accessKey;
    data['can_comment'] = canComment;
    data['can_like'] = canLike;
    data['can_repost'] = canRepost;
    data['can_subscribe'] = canSubscribe;
    data['can_add_to_faves'] = canAddToFaves;
    data['can_add'] = canAdd;
    data['comments'] = comments;
    data['date'] = date;
    data['description'] = description;
    data['duration'] = duration;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (firstFrame != null) {
      data['first_frame'] = firstFrame!.map((v) => v.toJson()).toList();
    }
    data['width'] = width;
    data['height'] = height;
    data['id'] = id;
    data['owner_id'] = ownerId;
    data['title'] = title;
    data['is_favorite'] = isFavorite;
    data['track_code'] = trackCode;
    data['repeat'] = repeat;
    data['type'] = type;
    data['views'] = views;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['with_padding'] = withPadding;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['platform'] = platform;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['can_post'] = canPost;
    data['count'] = count;
    data['groups_can_post'] = groupsCanPost;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['can_like'] = canLike;
    data['count'] = count;
    data['user_likes'] = userLikes;
    data['can_publish'] = canPublish;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['user_reposted'] = userReposted;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_donut'] = isDonut;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['type'] = type;
    data['name'] = name;
    return data;
  }
}
