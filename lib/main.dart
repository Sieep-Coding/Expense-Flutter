import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
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













// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const ExpenseTrackerApp());
// }
//
// class ExpenseTrackerApp extends StatelessWidget {
//   const ExpenseTrackerApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Expense Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         brightness: Brightness.dark,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const HomePage(),
//         '/settings': (context) => const SettingsPage(),
//       },
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Expense> expenses = [];
//
//   void _addExpense(
//       String title, double amount, DateTime date, String category) {
//     setState(() {
//       expenses.add(Expense(title, amount, date, category));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Expense Tracker'),
//         centerTitle: true,
//         actions:[
//           IconButton(icon: const Icon(Icons.settings),
//           onPressed: () {
//             Navigator.pushNamed(context, '/settings');
//           },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 25),
//           // const Text(
//           //   'Your Expenses',
//           //   style: TextStyle(
//           //     fontSize: 24,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.white,
//           //   ),
//           // ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: expenses.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: Colors.grey[800],
//                   child: ListTile(
//                     title: Text(
//                       expenses[index].title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       '${expenses[index].amount} - ${expenses[index].date.toString().split(' ')[0]} - ${expenses[index].category}',
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         setState(() {
//                           expenses.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AddExpenseDialog(addExpense: _addExpense),
//           );
//         },
//         backgroundColor: Colors.teal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class Expense {
//   final String title;
//   final double amount;
//   final DateTime date;
//   final String category;
//
//   Expense(this.title, this.amount, this.date, this.category);
// }
//
// class AddExpenseDialog extends StatefulWidget {
//   final Function(String, double, DateTime, String) addExpense;
//
//   const AddExpenseDialog({super.key, required this.addExpense});
//
//   @override
//   State<AddExpenseDialog> createState() => _AddExpenseDialogState();
// }
//
// class _AddExpenseDialogState extends State<AddExpenseDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//   DateTime? _date;
//   String? _expenseType;
//   String? _category;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.grey[800],
//       title: const Text(
//         'Add Expense',
//         style: TextStyle(color: Colors.white),
//       ),
//
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                 ),
//               ),
//               style: const TextStyle(color: Colors.white),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 8),
//             TextFormField(
//               controller: _amountController,
//               decoration: const InputDecoration(
//                 labelText: 'Amount',
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                 ),
//               ),
//               style: const TextStyle(color: Colors.white),
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an amount';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 8),
//             ListTile(
//               title: const Text(
//                 'Date',
//                 style: TextStyle(color: Colors.white),
//               ),
//               trailing: Text(
//                 _date == null ? 'Select Date' : _date.toString().split(' ')[0],
//                 style: const TextStyle(color: Colors.white),
//               ),
//               onTap: () async {
//                 final pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                   builder: (context, child) {
//                     return Theme(
//                       data: ThemeData.dark().copyWith(
//                         colorScheme: const ColorScheme.dark(
//                           primary: Colors.teal,
//                           onPrimary: Colors.white,
//                           surface: Colors.grey,
//                           onSurface: Colors.white,
//                         ),
//                       ),
//                       child: child!,
//                     );
//                   },
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     _date = pickedDate;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               value: _category,
//               decoration: const InputDecoration(
//                 labelText: 'Expense Type',
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                 ),
//               ),
//               dropdownColor: Colors.grey[800],
//               style: const TextStyle(color: Colors.white),
//               items: const [
//                 DropdownMenuItem(
//                   value: 'Food',
//                   child: Text('Food'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Transportation',
//                   child: Text('Transportation'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Living',
//                   child: Text('Living'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Entertainment',
//                   child: Text('Entertainment'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Misc.',
//                   child: Text('Misc.'),
//                 ),
//               ],
//
//               onChanged: (value) {
//                 setState(() {
//                   _category = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please select a category';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               value: _expenseType,
//               decoration: const InputDecoration(
//                 labelText: 'Frequency',
//                 labelStyle: TextStyle(color: Colors.white),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.teal),
//                 ),
//               ),
//               dropdownColor: Colors.grey[800],
//               style: const TextStyle(color: Colors.white),
//               items: const [
//                 DropdownMenuItem(
//                   value: 'Daily',
//                   child: Text('Daily'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Weekly',
//                   child: Text('Weekly'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Monthly',
//                   child: Text('Monthly'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Bi-Monthly',
//                   child: Text('Bi-Monthly'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Yearly',
//                   child: Text('Yearly'),
//                 ),
//               ],
//
//               onChanged: (value) {
//                 setState(() {
//                   _expenseType = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please select a category';
//                 }
//                 return null;
//               },
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text(
//             'Cancel',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               widget.addExpense(
//                 _titleController.text,
//                 double.parse(_amountController.text),
//                 _date!,
//                 _category!,
//               );
//               Navigator.pop(context);
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.teal,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _amountController.dispose();
//     super.dispose();
//   }
// }
//
// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Settings Page',
//               style: TextStyle(fontSize: 24),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Go Back'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }