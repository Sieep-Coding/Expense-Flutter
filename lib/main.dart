import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'data_source_picker.dart';
import 'data_model.dart';

void main() {
  runApp(const BusinessIntelligenceApp());
}

class BusinessIntelligenceApp extends StatelessWidget {
  const BusinessIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Intelligence',
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
  List<DataModel> data = [];

  void _loadData(String dataSource, String fileType) async {
    // Implement data loading logic here based on the data source and file type
    // You might need to use packages like csv or http to load data from files or APIs
    // For example:
    // if (fileType == 'csv') {
    //   final csvData = await rootBundle.loadString('path/to/data.csv');
    //   final rows = const CsvToListConverter().convert(csvData);
    //   // Process rows and add to data list
    // } else if (fileType == 'json') {
    //   final jsonData = await rootBundle.loadString('path/to/data.json');
    //   final jsonList = jsonDecode(jsonData) as List<dynamic>;
    //   // Process jsonList and add to data list
    // }

    setState(() {
      // Add loaded data to the data list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Business Intelligence'),
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
          const Text(
            'Data Sources',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Implement data details view or action here
                  },
                  child: Card(
                    color: Colors.grey[800],
                    child: ListTile(
                      leading: _getDataIcon(data[index].dataType),
                      title: Text(
                        data[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        data[index].description,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            data.removeAt(index);
                          });
                        },
                      ),
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
            builder: (context) => DataSourcePickerDialog(loadData: _loadData),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Icon _getDataIcon(String dataType) {
    switch (dataType) {
      case 'Sales':
        return const Icon(Icons.shopping_cart, color: Colors.white);
      case 'Finance':
        return const Icon(Icons.attach_money, color: Colors.white);
      case 'Marketing':
        return const Icon(Icons.campaign, color: Colors.white);
      default:
        return const Icon(Icons.data_object, color: Colors.white);
    }
  }
}

class DataSourcePickerDialog extends StatefulWidget {
  final Function(String, String) loadData;

  const DataSourcePickerDialog({super.key, required this.loadData});

  @override
  State<DataSourcePickerDialog> createState() => _DataSourcePickerDialogState();
}

class _DataSourcePickerDialogState extends State<DataSourcePickerDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _dataSource;
  String? _fileType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      title: const Text(
        'Load Data',
        style: TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _dataSource,
                decoration: const InputDecoration(
                  labelText: 'Data Source',
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
                    value: 'Local File',
                    child: Text('Local File'),
                  ),
                  DropdownMenuItem(
                    value: 'Remote API',
                    child: Text('Remote API'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _dataSource = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a data source';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 9),
              DropdownButtonFormField<String>(
                value: _fileType,
                decoration: const InputDecoration(
                  labelText: 'File Type',
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
                    value: 'csv',
                    child: Text('CSV'),
                  ),
                  DropdownMenuItem(
                    value: 'json',
                    child: Text('JSON'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _fileType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a file type';
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
              widget.loadData(_dataSource!, _fileType!);
              Navigator.pop(context);
            }
          },
          child: const Text('Load Data'),
        ),
      ],
    );
  }
}

// class DataModel {
//   final String title;
//   final String description;
//   final String dataType;
//
//   DataModel(this.title, this.description, this.dataType);
// }
