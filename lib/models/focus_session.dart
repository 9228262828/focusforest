class FocusSession {
  const FocusSession({
    required this.id,
    required this.minutes,
    required this.completedAt,
    required this.treeType,
  });

  final String id;
  final int minutes;
  final DateTime completedAt;
  final String treeType;

  Map<String, dynamic> toJson() => {
        'id': id,
        'minutes': minutes,
        'completedAt': completedAt.toIso8601String(),
        'treeType': treeType,
      };

  factory FocusSession.fromJson(Map<String, dynamic> json) {
    return FocusSession(
      id: json['id'] as String? ?? '',
      minutes: json['minutes'] as int? ?? 0,
      completedAt: DateTime.tryParse(json['completedAt'] as String? ?? '') ??
          DateTime.now(),
      treeType: json['treeType'] as String? ?? 'Oak',
    );
  }
}
