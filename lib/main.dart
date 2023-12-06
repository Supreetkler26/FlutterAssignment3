import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF121212), // Dark background color
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Index of the selected tab
  final List<Widget> _pages = [
    GreetingPage(),
    CalculatorPage(),
    ApiPage(),
    NotesPage(),
  ];

  // Function to blend two colors
  Color blendColors(Color color1, Color color2) {
    double ratio = 0.5; // Adjust the ratio for blending
    return Color.fromRGBO(
      ((color1.red * ratio) + (color2.red * (1 - ratio))).round(),
      ((color1.green * ratio) + (color2.green * (1 - ratio))).round(),
      ((color1.blue * ratio) + (color2.blue * (1 - ratio))).round(),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App : Assignment-3"),
        backgroundColor: blendColors(gradientColor1, gradientColor2),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate, color: Colors.white),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api, color: Colors.white),
            label: 'API',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes, color: Colors.white),
            label: 'Notes',
          ),
        ],
        backgroundColor: blendColors(gradientColor1, gradientColor2),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Function to handle bottom navigation bar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class GreetingPage extends StatelessWidget {
  // Function to blend two colors
  Color blendColors(Color color1, Color color2) {
    double ratio = 0.5; // Adjust the ratio for blending
    return Color.fromRGBO(55, 45, 85, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hello! Welcome to the Flutter Assignment App!',
            style: TextStyle(
                fontSize: 18,
                color: _MainPageState()
                    .blendColors(gradientColor1, gradientColor2)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.network(
            'https://static.vecteezy.com/system/resources/previews/015/636/822/original/illustration-of-karma-depicted-with-namaste-indian-women-s-hand-greeting-posture-of-namaste-with-lotus-flower-illustration-free-vector.jpg',
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Function to blend two colors
  Color blendColors(Color color1, Color color2) {
    double ratio = 0.5; // Adjust the ratio for blending
    return Color.fromRGBO(
      ((color1.red * ratio) + (color2.red * (1 - ratio))).round(),
      ((color1.green * ratio) + (color2.green * (1 - ratio))).round(),
      ((color1.blue * ratio) + (color2.blue * (1 - ratio))).round(),
      1.0,
    );
  }

  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = '';
  String selectedOperation = '+';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator Page"),
        backgroundColor: blendColors(gradientColor1, gradientColor2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedOperation,
              items: <String>['+', '-', '*', '/'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOperation = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number 1',
                labelStyle: TextStyle(
                    color: blendColors(gradientColor1, gradientColor2)),
              ),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number 2',
                labelStyle: TextStyle(
                    color: blendColors(gradientColor1, gradientColor2)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculate();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $result',
              style: TextStyle(
                  fontSize: 18,
                  color: blendColors(gradientColor1, gradientColor2)),
            ),
          ],
        ),
      ),
    );
  }

  // Function to perform calculation based on selected operation
  void calculate() {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double resultValue = 0;

    switch (selectedOperation) {
      case '+':
        resultValue = num1 + num2;
        break;
      case '-':
        resultValue = num1 - num2;
        break;
      case '*':
        resultValue = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          resultValue = num1 / num2;
        } else {
          result = 'Error: Division by zero';
          return;
        }
        break;
    }

    setState(() {
      result = resultValue.toString();
    });
  }
}

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Dio dio = Dio();
  List<dynamic> posts = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              fetchApiData();
            },
            child: Text('Fetch API Data'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  title: posts[index]['title'],
                  body: posts[index]['body'],
                  userId: posts[index]['userId'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to fetch data from the API
  void fetchApiData() async {
    try {
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      List<dynamic> data = response.data; // Use response.data directly

      setState(() {
        posts = data.take(20).toList();
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  final int userId;

  PostCard({
    required this.title,
    required this.body,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title.isNotEmpty ? title : 'No data',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Body: ${body.isNotEmpty ? body : 'No data'}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'User ID: $userId',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];
  TextEditingController noteController = TextEditingController();

  // Function to blend two colors
  Color blendColors(Color color1, Color color2) {
    double ratio = 0.5; // Adjust the ratio for blending
    return Color.fromRGBO(
      ((color1.red * ratio) + (color2.red * (1 - ratio))).round(),
      ((color1.green * ratio) + (color2.green * (1 - ratio))).round(),
      ((color1.blue * ratio) + (color2.blue * (1 - ratio))).round(),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        backgroundColor: blendColors(gradientColor1, gradientColor2),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    notes[index],
                    style: TextStyle(
                      color: blendColors(gradientColor1, gradientColor2),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: "Add a Note",
                labelStyle: TextStyle(
                  color: blendColors(gradientColor1, gradientColor2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: blendColors(gradientColor1, gradientColor2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: blendColors(gradientColor1, gradientColor2),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              saveNote();
            },
            child: Text("Save Note"),
            style: ElevatedButton.styleFrom(
              primary: blendColors(gradientColor1, gradientColor2),
            ),
          ),
        ],
      ),
    );
  }

  // Function to save a note
  void saveNote() {
    setState(() {
      notes.add(noteController.text);
      noteController.text = "";
    });
  }
}

// Gradient color values
final Color gradientColor1 = Color.fromRGBO(50, 173, 230, 1.0);
final Color gradientColor2 = Color.fromRGBO(50, 173, 230, 1.0);
