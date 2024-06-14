import 'package:flutter/material.dart';
import 'expense.dart';
import 'settings_page.dart';
import 'background.dart';
import 'add_expense_dialog.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThriftyTrail',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense> expenses = [];

  void _addExpense(
      String title, double amount, DateTime date, String category) {
    setState(() {
      expenses.add(Expense(title, amount, date, category));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Start A Trail'),
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
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(
                      expenses[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${expenses[index].amount} - ${expenses[index].date.toString().split(' ')[0]} - ${expenses[index].category}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          expenses.removeAt(index);
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
            builder: (context) => AddExpenseDialog(addExpense: _addExpense),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
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
    return Stack(
      children: [
        // Background Widget with Icon (using BackgroundWidget)
        BackgroundWidget(), // Use the BackgroundWidget here

        // AlertDialog on top of Background
        AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text(
            'Add Expense',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text(
                      'Reoccurring Date',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      _date == null ? 'Select Date' : _date.toString().split(' ')[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Colors.teal,
                                onPrimary: Colors.white,
                                surface: Colors.grey,
                                onSurface: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _date = pickedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    dropdownColor: Colors.grey[800],
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(
                        value: 'Food',
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: 'Transportation',
                        child: Text('Transportation'),
                      ),
                      DropdownMenuItem(
                        value: 'Living',
                        child: Text('Living'),
                      ),
                      DropdownMenuItem(
                        value: 'Entertainment',
                        child: Text('Entertainment'),
                      ),
                      DropdownMenuItem(
                        value: 'Misc.',
                        child: Text('Misc.'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _category = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _expenseType,
                    decoration: const InputDecoration(
                      labelText: 'Frequency',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    dropdownColor: Colors.grey[800],
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'Monthly',
                        child: Text('Monthly'),
                      ),
                      DropdownMenuItem(
                        value: 'Bi-Monthly',
                        child: Text('Bi-Monthly'),
                      ),
                      DropdownMenuItem(
                        value: 'Yearly',
                        child: Text('Yearly'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _expenseType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a frequency';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
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
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
