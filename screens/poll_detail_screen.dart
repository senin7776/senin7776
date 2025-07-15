import 'package:flutter/material.dart';
import 'package:voting_app/models/poll.dart';
import 'package:voting_app/widgets/option_tile.dart';
import 'package:voting_app/widgets/result_chart.dart';

class PollDetailScreen extends StatelessWidget {
  final Poll poll;
  final Function(String, String) onVote;

  const PollDetailScreen({
    super.key,
    required this.poll,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poll.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ResultChart(poll: poll),
            const SizedBox(height: 24),
            const Text(
              'Vote Now:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...poll.options.map((option) => OptionTile(
                  option: option,
                  votes: poll.votes[option] ?? 0,
                  totalVotes: poll.totalVotes,
                  onVote: () => onVote(poll.id, option),
                )),
            const SizedBox(height: 16),
            Text(
              'Created by: ${poll.creator}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Total votes: ${poll.totalVotes}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}