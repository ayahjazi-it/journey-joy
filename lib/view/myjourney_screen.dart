import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/cash_helper.dart';
import 'package:flutter_application_1/models/user_contacts_model.dart';
import 'package:flutter_application_1/services/user_contaacte_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyJourney extends StatefulWidget {
  @override
  _MyJourneyState createState() => _MyJourneyState();
  static String screenRoot = 'drowp_screen';
}

class _MyJourneyState extends State<MyJourney> {
  List<ContactsModel> _allContacts = [];
  List<ContactsModel> _selectedContacts = [];
  bool _isLoading = true;
  bool _showAdditionalFields = false;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hotelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      String? token = CashHelper.getUserToken();
      AllContactsService service = AllContactsService();
      List<ContactsModel> contacts = await service.fetchcontacts();
      setState(() {
        _allContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching contacts: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMultiSelectDialog() async {
    final List<ContactsModel>? selectedValues =
        await showDialog<List<ContactsModel>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          contacts: _allContacts,
          selectedContacts: _selectedContacts,
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        _selectedContacts = selectedValues;
        _showAdditionalFields = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Select Dropdown Example'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showMultiSelectDialog,
              child: Text('Select Contacts'),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Selected Contacts: ${_selectedContacts.isNotEmpty ? _selectedContacts.map((contact) => contact.name).join(', ') : 'None'}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            if (_showAdditionalFields) ...[
              SizedBox(height: 20),
              _buildTextField(_startDateController, 'Start Date'),
              SizedBox(height: 10),
              _buildTextField(_endDateController, 'End Date'),
              SizedBox(height: 10),
              _buildTextField(_countryController, 'destination_region'),
              SizedBox(height: 10),
              _buildTextField(_nameController, 'startPlace_region'),
              SizedBox(height: 10),
              _buildTextField(_hotelController, 'Residence_hotel'),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final startDate = '5/5/2020';
                    final endDate = '6/6/2020';
                    final destinationRegion = 'damas';
                    final startPlaceRegion = 'lebanon';
                    final residenceHotel = 'sssss';

                    sendJourneyWithToken(
                      startDate: startDate,
                      endDate: endDate,
                      destinationRegion: destinationRegion,
                      startPlaceRegion: startPlaceRegion,
                      residenceHotel: residenceHotel,
                      userIds: [],
                      optionalActivityIds: [], // إذا لم يكن لديك أنشطة اختيارية، اجعلها قائمة فارغة
                    );
                  },
                  child: Text('Done'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }

  void sendJourneyWithToken({
    required String startDate,
    required String endDate,
    required String destinationRegion,
    required String startPlaceRegion,
    required String residenceHotel,
    required List<int> userIds,
    required List<int> optionalActivityIds,
  }) async {
    try {
      // استرجاع التوكن من SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(token);
      if (token == null) {
        print('Token not found');
        return;
      }

      // استدعاء التابع sendJourney وتمرير التوكن
      await sendJourney(
        token: token,
        startDate: startDate,
        endDate: endDate,
        destinationRegion: destinationRegion,
        startPlaceRegion: startPlaceRegion,
        residenceHotel: residenceHotel,
        userIds: userIds,
        optionalActivityIds: optionalActivityIds,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> sendJourney({
    required String token,
    required String startDate,
    required String endDate,
    required String destinationRegion,
    required String startPlaceRegion,
    required String residenceHotel,
    required List<int> userIds,
    required List<int> optionalActivityIds,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.142:8000/api/reservation/private-journey'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "start_date": startDate,
          "end_date": endDate,
          "destination_region": destinationRegion,
          "startPlace_region": startPlaceRegion,
          "Residence_hotel": residenceHotel,
          "user_ids": userIds,
          "optional_activity_ids": optionalActivityIds,
        }),
      );

      if (response.statusCode == 200) {
        print('Journey added successfully');
      } else {
        print('Error journey added : ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<ContactsModel> contacts;
  final List<ContactsModel> selectedContacts;

  MultiSelectDialog({required this.contacts, required this.selectedContacts});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<ContactsModel> _tempSelectedContacts = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedContacts = List.from(widget.selectedContacts);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Contacts'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.contacts.map((contact) {
            return CheckboxListTile(
              value: _tempSelectedContacts.contains(contact),
              title: Text('${contact.name} (${contact.mobile})'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    if (value) {
                      _tempSelectedContacts.add(contact);
                    } else {
                      _tempSelectedContacts.remove(contact);
                    }
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_tempSelectedContacts);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
