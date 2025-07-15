class Poll {
  final String id;
  final String question;
  final List<String> options;
  final Map<String, int> votes;
  final String creator;
  final DateTime createdAt;
  final DateTime? expiresAt;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.votes,
    required this.creator,
    required this.createdAt,
    this.expiresAt,
  });

  int get totalVotes => votes.values.fold(0, (sum, count) => sum + count);

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      votes: Map<String, int>.from(json['votes']),
      creator: json['creator'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    );
  }
}