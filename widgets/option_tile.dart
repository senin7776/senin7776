import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final int votes;
  final int totalVotes;
  final VoidCallback onVote;

  const OptionTile({
    super.key,
    required this.option,
    required this.votes,
    required this.totalVotes,
    required this.onVote,
  });

  double get percentage => totalVotes > 0 ? votes / totalVotes : 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onVote,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(percentage * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '$votes votes',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}