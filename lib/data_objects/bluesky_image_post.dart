class BskyImagePost {
  final List<BskyImage> images;

  BskyImagePost({
    required this.images,
  });

  @override
  String toString() {
    return 'BskyImagePost(images: ${images.map((image) => image.toString()).join(', ')})';
  }
}

class BskyImage {
  final String thumb;
  final String url;
  final String alt;
  final BskyAspectRatio aspectRatio;

  BskyImage({
    required this.thumb,
    required this.url,
    required this.alt,
    required this.aspectRatio,
  });

  factory BskyImage.fromJson(Map<String, dynamic> json) {
    return BskyImage(
      thumb: json['thumb'] as String,
      url: json['fullsize'] as String,
      alt: json['alt'] as String,
      aspectRatio: BskyAspectRatio(
        width: (json['aspectRatio']['width'] as num),
        height: (json['aspectRatio']['height'] as num),
      ),
    );
  }

  @override
  String toString() {
    return 'BskyImage(thumb: $thumb, url: $url, alt: $alt, aspectRatio: ${aspectRatio.ratio})';
  }
}

class BskyAspectRatio {
  final num width;
  final num height;

  BskyAspectRatio({
    required this.width,
    required this.height,
  });

  double get ratio => width / height;
}
