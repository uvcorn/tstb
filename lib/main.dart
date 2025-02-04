import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(
        fontFamily: 'Arial', // Set a default font (adjust as needed)
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> dataList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void _addData() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      setState(() {
        dataList.add({
          'name': nameController.text,
          'number': numberController.text,
        });
        nameController.clear();
        numberController.clear();
      });
    }
  }

  void _deleteData(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure for Delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.blueGrey)), // Style the button
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  dataList.removeAt(index);
                });
              },
              child: Text('Delete',
                  style: TextStyle(color: Colors.red)), // Style the button
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(), // Add border
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.phone, // More appropriate keyboard
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(), // Add border
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _addData,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15), // Adjust padding
              ),
              child: Text('Add'),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8), // Adjust spacing
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)
                          // Text(dataList[index]['name']![0]
                          //     .toUpperCase()),

                          ),
                      title: Text(dataList[index]['name']!),
                      subtitle: Text(dataList[index]['number']!),
                      trailing: IconButton(
                        // Add a trailing icon button
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          // Handle phone call logic here
                        },
                      ),
                      onLongPress: () => _deleteData(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
