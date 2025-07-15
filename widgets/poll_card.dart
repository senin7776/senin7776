import 'package:flutter/material.dart';
import 'package:voting_app/models/poll.dart';

class PollCard extends StatelessWidget {
  final Poll poll;

  const PollCard({super.key, required this.poll});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poll.question,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '${poll.options.length} options • ${poll.totalVotes} votes',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (poll.expiresAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Ends in ${poll.expiresAt!.difference(DateTime.now()).inDays} days',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}