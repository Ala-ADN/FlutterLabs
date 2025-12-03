import 'package:flutter/material.dart';
import '../../widgets/custom_input_decoration.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/SignUp";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String username = '';
  String email = '';
  String password = '';
  String birthdate = '';
  String address = '';

  bool _isValidDate(String input) {
    try {
      final parts = input.split('/');
      if (parts.length != 3) return false;
      
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      if (year < 1900 || year > DateTime.now().year) return false;
      if (month < 1 || month > 12) return false;
      if (day < 1 || day > 31) return false;
      
      final parsedDate = DateTime(year, month, day);
      return parsedDate.year == year && parsedDate.month == month && parsedDate.day == day;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Image.asset(
                  "assets/insat.jpg",
                  width: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 250,
                      height: 150,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Username",
                  "Enter Your Username",
                  const Icon(Icons.person_3_outlined),
                ).customInputDecoration(),
                onSaved: (newValue) => username = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Email",
                  "Enter Your Email",
                  const Icon(Icons.email_outlined),
                ).customInputDecoration(),
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email should not be empty";
                  }
                  if (!value.contains('@')) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Password",
                  "Enter Your Password",
                  const Icon(Icons.lock_outlined),
                ).customInputDecoration(),
                obscureText: true,
                onSaved: (newValue) => password = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password should not be empty";
                  }
                  if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Birthdate",
                  "Enter Your Birthdate (DD/MM/YYYY)",
                  const Icon(Icons.calendar_today_outlined),
                ).customInputDecoration(),
                keyboardType: TextInputType.datetime,
                onSaved: (newValue) => birthdate = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Birthdate should not be empty";
                  }
                  if (!_isValidDate(value)) {
                    return "Please enter a valid date (DD/MM/YYYY)";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Address",
                  "Enter Your Address",
                  const Icon(Icons.location_on_outlined),
                ).customInputDecoration(),
                maxLines: 2,
                onSaved: (newValue) => address = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address should not be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Sign Up"),
                          content: const Text(
                            "User added successfully! Check your inbox",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
