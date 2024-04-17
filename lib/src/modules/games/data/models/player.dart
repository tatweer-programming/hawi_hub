class GamePlayer {
  final String name;
  final int id;
  final String imageUrl;
  final bool isHost;
  const GamePlayer(
      {required this.name, required this.id, required this.imageUrl, this.isHost = false});
  factory GamePlayer.fromJson(Map<String, dynamic> json) {
    return GamePlayer(
      isHost: json['is_host'],
      name: json['name'],
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'is_host': isHost,
      'name': name,
      'id': id,
      'image_url': imageUrl,
    };
  }
}
