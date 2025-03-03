import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';

class CookingInstructions extends StatefulWidget {
  final Function(List<String>) onInstructionsUpdated;
  const CookingInstructions({super.key, required this.onInstructionsUpdated});

  @override
  State<CookingInstructions> createState() => _CookingInstructionsState();
}

class _CookingInstructionsState extends State<CookingInstructions> {
  final _instructionsController = TextEditingController();
  final List<String> _instructionsList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _instructionsController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 3, // Allow multiple lines but limit it
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
            labelText: 'Cooking Instructions',
            prefixIcon: Icon(Icons.receipt_long),
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: _addInstruction, // Add instruction on button click
            ),
          ),
          onSubmitted: (value) => _addInstruction(), // Add instruction on Enter
        ),
        kHeight10,
        if (_instructionsList.isEmpty)
          Text(
            'Please add at least an instruction.',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _instructionsList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${index + 1}. ${_instructionsList[index]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 16,
                      ),
                      onPressed: () => _removeInstruction(index),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addInstruction() {
    if (_instructionsController.text.trim().isNotEmpty) {
      setState(() {
        _instructionsList.add(_instructionsController.text.trim());
        _instructionsController.clear();
      });
      widget.onInstructionsUpdated(_instructionsList);
    }
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructionsList.removeAt(index);
      widget.onInstructionsUpdated(_instructionsList);
    });
  }
}
