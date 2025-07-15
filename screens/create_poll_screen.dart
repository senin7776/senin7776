import 'package:flutter/material.dart';
import 'package:voting_app/models/poll.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 2) {
      setState(() {
        _optionControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Poll'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Poll Question',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._optionControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Option ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter option text';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () => _removeOption(index),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addOption,
                child: const Text('Add Option'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final options = _optionControllers
                        .map((controller) => controller.text)
                        .toList();
                    
                    final newPoll = Poll(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      question: _questionController.text,
                      options: options,
                      votes: {for (var option in options) option: 0},
                      creator: 'Current User',
                      createdAt: DateTime.now(),
                    );
                    
                    Navigator.pop(context, newPoll);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Create Poll'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}