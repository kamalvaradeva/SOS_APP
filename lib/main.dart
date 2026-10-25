import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:telephony/telephony.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
List<String> emergencyContacts = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  emergencyContacts =
      prefs.getStringList('emergency_contacts') ?? [];

  runApp(const SOSApp());
}

class SOSApp extends StatelessWidget {
  const SOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PatternScreen(),
    );
  }
}

class PatternScreen extends StatefulWidget {
  const PatternScreen({super.key});

  @override
  State<PatternScreen> createState() => _PatternScreenState();
}

class _PatternScreenState extends State<PatternScreen> {
  // Telephony instance
  final Telephony telephony = Telephony.instance;

  // Emergency contacts


  // Secret pattern: 0 -> 1 -> 2 -> 5
  final List<int> correctPattern = [0, 1, 2, 5];

  // Send SOS SMS
  Future<void> sendSOS() async {
    bool? permission =
    await telephony.requestPhoneAndSmsPermissions;

    if (permission != true) {
      return;
    }

    const String message =
        '🚨 SOS ALERT! I need immediate help. Please reach me immediately.';


    for (String number in emergencyContacts) {
      await telephony.sendSms(
        to: number,
        message: message,
      );
    }
  }

  // Check pattern
  void checkPattern(List<int> input) async {
    if (input.toString() == correctPattern.toString()) {
      // Send emergency SMS
      await sendSOS();

      // Open fake calculator screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FakeCalculatorScreen(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong Pattern'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Draw Pattern',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 350,
                width: 350,
                child: PatternLock(
                  selectedColor: Colors.red,
                  notSelectedColor: Colors.white,
                  pointRadius: 10,
                  dimension: 3,
                  relativePadding: 0.7,
                  onInputComplete: (input) {
                    checkPattern(input);
                  },
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactScreen(),
                    ),
                  );
                },
                child: const Text("Emergency Contacts"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FakeCalculatorScreen extends StatefulWidget {
  const FakeCalculatorScreen({super.key});

  @override
  State<FakeCalculatorScreen> createState() =>
      _FakeCalculatorScreenState();
}

class _FakeCalculatorScreenState
    extends State<FakeCalculatorScreen> {

  String display = "0";

  void pressButton(String value) {

    setState(() {

      if (display == "0") {
        display = value;
      } else {
        display += value;
      }

    });

  }

  Widget calcButton(String text) {

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            pressButton(text);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: Colors.grey.shade800,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Calculator"),
      ),

      body: Column(
        children: [

          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
            ),
          ),

          Row(
            children: [
              calcButton("1"),
              calcButton("2"),
              calcButton("3"),
            ],
          ),

          Row(
            children: [
              calcButton("4"),
              calcButton("5"),
              calcButton("6"),
            ],
          ),

          Row(
            children: [
              calcButton("7"),
              calcButton("8"),
              calcButton("9"),
            ],
          ),

          Row(
            children: [
              calcButton("0"),
              calcButton("+"),
              calcButton("="),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );

  }
}
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController contactController = TextEditingController();

  Future<void> saveContacts() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'emergency_contacts',
      emergencyContacts,
    );

  }

  void addContact() {

    if (contactController.text.isNotEmpty) {

      setState(() {

        emergencyContacts.add(contactController.text);

      });

      saveContacts();

      contactController.clear();

    }

  }
  Future<void> loadContacts() async {

    final prefs = await SharedPreferences.getInstance();

    emergencyContacts =
        prefs.getStringList('emergency_contacts') ?? [];

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Emergency Contacts"),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Enter phone number",
                hintStyle: const TextStyle(color: Colors.grey),

                filled: true,
                fillColor: Colors.grey.shade900,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: addContact,
              child: const Text("Add Contact"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,

                itemBuilder: (context, index) {

                  return Card(
                    color: Colors.grey.shade900,

                    child: ListTile(

                      title: Text(
                        emergencyContacts[index],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      trailing: IconButton(

                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),

                        onPressed: ()  {

                          setState(() {

                            emergencyContacts.removeAt(index);


                          });
                          saveContacts();

                        },

                      ),

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
  @override
  void initState() {
    super.initState();

    loadContacts();
  }

}