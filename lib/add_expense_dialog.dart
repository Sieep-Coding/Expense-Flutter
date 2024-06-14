import 'package:flutter/material.dart';

class AddExpenseDialog extends StatefulWidget {
  final Function(String, double, DateTime, String) addExpense;

  const AddExpenseDialog({Key? key, required this.addExpense}) : super(key: key);

  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _date;
  String? _expenseType;
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          // const Text(
          //   'Your Expenses',
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //   ),
          // ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 1, // Set the correct itemCount
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(
                      _titleController.text, // Use _titleController instead of expenses[index].title
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${_amountController.text} - ${_date.toString().split(' ')[0]} - $_category', // Use _amountController, _date, and _category
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          // Clear text fields
                          _titleController.clear();
                          _amountController.clear();
                          _date = null;
                          _category = null;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Expense'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Form fields go here
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.addExpense(
                        _titleController.text,
                        double.parse(_amountController.text),
                        _date!,
                        _category!,
                      );
                      // Clear text fields
                      _titleController.clear();
                      _amountController.clear();
                      _date = null;
                      _category = null;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
