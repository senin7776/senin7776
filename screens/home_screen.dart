import 'package:flutter/material.dart';
import 'package:voting_app/mock_data.dart';
import 'package:voting_app/models/poll.dart';
import 'package:voting_app/screens/create_poll_screen.dart';
import 'package:voting_app/screens/poll_detail_screen.dart';
import 'package:voting_app/widgets/poll_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Poll> polls = [];

  @override
  void initState() {
    super.initState();
    polls = mockPolls;
  }

  void _addPoll(Poll newPoll) {
    setState(() {
      polls = [newPoll, ...polls];
    });
  }

  void _handleVote(String pollId, String option) {
    setState(() {
      final pollIndex = polls.indexWhere((poll) => poll.id == pollId);
      if (pollIndex != -1) {
        final updatedPoll = Poll(
          id: polls[pollIndex].id,
          question: polls[pollIndex].question,
          options: polls[pollIndex].options,
          votes: Map.from(polls[pollIndex].votes)..update(
              option,
              (value) => value + 1,
              ifAbsent: () => 1,
            ),
          creator: polls[pollIndex].creator,
          createdAt: polls[pollIndex].createdAt,
          expiresAt: polls[pollIndex].expiresAt,
        );
        polls[pollIndex] = updatedPoll;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll Pulse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePollScreen(),
                ),
              );
              if (result != null && result is Poll) {
                _addPoll(result);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: polls.length,
        itemBuilder: (context, index) {
          final poll = polls[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PollDetailScreen(
                    poll: poll,
                    onVote: _handleVote,
                  ),
                ),
              );
            },
            child: PollCard(poll: poll),
          );
        },
      ),
    );
  }
}