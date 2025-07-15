import 'package:voting_app/models/poll.dart';

List<Poll> mockPolls = [
  Poll(
    id: '1',
    question: 'Which Flutter state management do you prefer?',
    options: ['Provider', 'Bloc', 'Riverpod', 'GetX', 'Redux'],
    votes: {'Provider': 12, 'Bloc': 8, 'Riverpod': 15, 'GetX': 5, 'Redux': 3},
    creator: 'user1@example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Poll(
    id: '2',
    question: 'What\'s your favorite programming language?',
    options: ['Dart', 'JavaScript', 'Python', 'Java', 'C#'],
    votes: {'Dart': 20, 'JavaScript': 15, 'Python': 25, 'Java': 10, 'C#': 8},
    creator: 'user2@example.com',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  Poll(
    id: '3',
    question: 'How do you like your coffee?',
    options: ['Black', 'With milk', 'Iced', 'No coffee'],
    votes: {'Black': 7, 'With milk': 12, 'Iced': 9, 'No coffee': 4},
    creator: 'user3@example.com',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    expiresAt: DateTime.now().add(const Duration(days: 1)),
  ),
];