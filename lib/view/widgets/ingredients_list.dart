import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';

class IngredientsList extends StatefulWidget {
  final Function(List<String>) onIngredientsUpdated;

  const IngredientsList({super.key, required this.onIngredientsUpdated});

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  final _ingredientsController = TextEditingController();
  List<String> _ingredientsList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //ingredients list
        TextField(
          controller: _ingredientsController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
            labelText: 'Ingredients',
            prefixIcon: Icon(Icons.list_alt_rounded),
            suffixIcon: IconButton(
              icon: Icon(Icons.add),
              onPressed: _addIngredient, // Add ingredient on button click
            ),
          ),
          onSubmitted: (value) => _addIngredient(), // Add ingredient on Enter
        ),
        kHeight10,
        if (_ingredientsList.length < 2)
          Text(
            'Please add at least two ingredients.',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        Wrap(
          spacing: 8.0,
          children: _ingredientsList.asMap().entries.map((entry) {
            int index = entry.key;
            String ingredient = entry.value;
            return Chip(
              label: Text(ingredient),
              deleteIcon: Icon(Icons.close),
              onDeleted: () => _removeIngredient(index),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _addIngredient() {
    String ingredient = _ingredientsController.text.trim();
    if (ingredient.isNotEmpty) {
      setState(() {
        _ingredientsList.add(ingredient);
        _ingredientsController.clear();
      });
      widget.onIngredientsUpdated(_ingredientsList); // Notify parent widget
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientsList.removeAt(index);
      widget.onIngredientsUpdated(_ingredientsList); // Notify parent widget
    });
  }

   void clearList() {
    setState(() {
      _ingredientsList = [];
    });
  }
}
