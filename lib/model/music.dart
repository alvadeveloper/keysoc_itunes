class Music {
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? collectionViewUrl;
  final String? artworkUrl100;
  final double? collectionPrice;
  final double? trackPrice;
  final String? currency;

  Music(
      {this.artistName,
      this.collectionName,
      this.trackName,
      this.collectionViewUrl,
      this.artworkUrl100,
      this.collectionPrice,
      this.trackPrice,
      this.currency});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
        artistName: json['artistName'] as String?,
        collectionName: json['collectionName'] as String?,
        trackName: json['trackName'] as String?,
        collectionViewUrl: json['collectionViewUrl'] as String?,
        artworkUrl100: json['artworkUrl100'] as String?,
        collectionPrice: json['collectionPrice'] as double?,
        trackPrice: json['trackPrice'] as double?,
        currency: json['currency'] as String?);
  }
}
