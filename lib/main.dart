import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'RGB'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _red = 0;
  int _green = 0;
  int _blue = 0;
  int _val = 1;
  bool wasPressedMaxMin = false;
  bool wasPressedVal = false;

  void _incrementColor(Function(int) setColor, int currentValue) {
    setState(() {
      if (currentValue < 255) {
        final newValue = (currentValue + _val).clamp(0, 255);
        setColor(newValue);
      }
    });
  }

  void _decrementColor(Function(int) setColor, int currentValue) {
    setState(() {
      final newValue = (currentValue - _val).clamp(0, 255);
      setColor(newValue);
    });
  }

  Widget _buildColorControl(
    String label,
    int value,
    Color activeColor,
    VoidCallback onDecrement,
    VoidCallback onIncrement,
  ) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: onIncrement,
              iconSize: 45,
              color: activeColor,
              tooltip: 'Aumentar $label',
            ),
            const SizedBox(height: 10),

            Text('$value', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),

            IconButton(
              icon: const Icon(Icons.indeterminate_check_box_outlined),
              onPressed: onDecrement,
              iconSize: 45,
              color: activeColor.withOpacity(0.7),
              tooltip: 'Diminuir $label',
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHexCode() {
    return '#${_red.toRadixString(16).padLeft(2, '0')}${_green.toRadixString(16).padLeft(2, '0')}${_blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = Color.fromRGBO(_red, _green, _blue, 1.0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentColor,
        title: Text(
          widget.title,
          style: TextStyle(
            color:
                ThemeData.estimateBrightnessForColor(currentColor) ==
                    Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: currentColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        _getHexCode(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              ThemeData.estimateBrightnessForColor(
                                    currentColor,
                                  ) ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorControl(
                      'Red',
                      _red,
                      Colors.red,
                      () => _decrementColor((val) => _red = val, _red),
                      () => _incrementColor((val) => _red = val, _red),
                    ),
                    _buildColorControl(
                      'Green',
                      _green,
                      Colors.green,
                      () => _decrementColor((val) => _green = val, _green),
                      () => _incrementColor((val) => _green = val, _green),
                    ),
                    _buildColorControl(
                      'Blue',
                      _blue,
                      Colors.blue,
                      () => _decrementColor((val) => _blue = val, _blue),
                      () => _incrementColor((val) => _blue = val, _blue),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          wasPressedMaxMin = !wasPressedMaxMin;
                          if (wasPressedMaxMin) {
                            setState(() {
                              _red = 255;
                              _green = 255;
                              _blue = 255;
                            });
                          } else {
                            setState(() {
                              _red = 0;
                              _green = 0;
                              _blue = 0;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 40.0,
                          ),
                        ),
                        child: wasPressedMaxMin
                            ? Text('Min', style: TextStyle(color: Colors.black))
                            : Text(
                                'Max',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          wasPressedVal = !wasPressedVal;
                          setState(() {
                            wasPressedVal ? _val = 2 : _val = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 40.0,
                          ),
                        ),
                        child: wasPressedVal
                            ? Text(
                                '+1/-1',
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                '+2/-2',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
