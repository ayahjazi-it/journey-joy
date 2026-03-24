import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/helper/cash_helper.dart';
import 'package:flutter_application_1/models/journey_model.dart';
import 'package:flutter_application_1/view/journey_show_screen.dart';
import 'package:flutter_application_1/widget/journey_card.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class JourneySearchScreen extends StatefulWidget {
  static String screenRoot = 'search_screen';

  @override
  _JourneySearchScreenState createState() => _JourneySearchScreenState();
}

class _JourneySearchScreenState extends State<JourneySearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Variables for search filters
  String _searchName = '';
  String? _selectedStartDate;
  String? _selectedEndDate;
  RangeValues _selectedPriceRange = RangeValues(0.0, 10000.0);
  final SearchController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  // List to store search results
  List<JourneyModel> _searchResults = [];
  bool _isSearchSuccess = false; // Added state for search success

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        String formattedDate = _dateFormat.format(pickedDate);
        if (isStartDate) {
          _selectedStartDate = formattedDate;
        } else {
          _selectedEndDate = formattedDate;
        }
      });
    }
  }

  Future<void> searchByName(String searchTerm) async {
    String? token = CashHelper.getUserToken();

    if (searchTerm.trim().isEmpty) {
      setState(() {
        _isSearchSuccess = false;
        _searchResults.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('A search term is required.')),
      );
      return;
    }

    // ترميز مصطلح البحث للتأكد من أن القيم التي تحتوي على أحرف خاصة يتم التعامل معها بشكل صحيح
    final encodedSearchTerm = Uri.encodeComponent(searchTerm);

    final Uri uri = Uri.parse('http://$localhost:8000/api/journey/search')
        .replace(queryParameters: {'search_term': encodedSearchTerm});

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _searchResults =
              responseData.map((data) => JourneyModel.fromJson(data)).toList();
          _isSearchSuccess = _searchResults.isNotEmpty;
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isSearchSuccess = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isSearchSuccess = false;
      });
    }
  }

  Future<void> searchByDate(String? stDate, String? enDate) async {
    String? token = CashHelper.getUserToken();
    try {
      final response = await http.post(
        Uri.parse('http://$localhost:8000/api/journey/searchByData'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'start_date': stDate,
          'end_date': enDate,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          _searchResults =
              responseData.map((data) => JourneyModel.fromJson(data)).toList();
          _isSearchSuccess = _searchResults.isNotEmpty;
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isSearchSuccess = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isSearchSuccess = false;
      });
    }
  }

  Future<void> searchByPrice(double? stPrice, double? enPrice) async {
    String? token = CashHelper.getUserToken();

    try {
      final response = await http.post(
        Uri.parse(
            'http://$localhost:8000/api/journey/searchJourneyByPrice'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'min_price': stPrice?.toString() ?? '0',
          'max_price': enPrice?.toString() ?? '0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print('Response body: ${response.body}');
        setState(() {
          _searchResults =
              responseData.map((data) => JourneyModel.fromJson(data)).toList();
          _isSearchSuccess = _searchResults.isNotEmpty;
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isSearchSuccess = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isSearchSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Journeys'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'By Name'),
            Tab(text: 'By Date'),
            Tab(text: 'By Price'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // By Name Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: SearchController,
                  decoration: InputDecoration(
                    labelText: 'Search by Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchName = value;
                      print('Search Name: $_searchName');
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_searchName.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('A search term is required.')),
                      );
                    } else {
                      searchByName(_searchName);
                    }
                  },
                  child: Text('Search'),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _isSearchSuccess
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Center(
                                child: Journeycard(
                                  Icons: true,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JourneyShow(
                                            Id: _searchResults[index].id!),
                                      ),
                                    );
                                  },
                                  journey: _searchResults[index],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No data available')),
                ),
              ],
            ),
          ),
          // By Date Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                        controller: TextEditingController(
                          text: _selectedStartDate ?? '',
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                        controller: TextEditingController(
                          text: _selectedEndDate ?? '',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    searchByDate(_selectedStartDate, _selectedEndDate);
                  },
                  child: Text('Search by Date'),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _isSearchSuccess
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Center(
                                child: Journeycard(
                                  Icons: true,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JourneyShow(
                                            Id: _searchResults[index].id!),
                                      ),
                                    );
                                  },
                                  journey: _searchResults[index],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No data available')),
                ),
              ],
            ),
          ),
          // By Price Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Range',
                  style: TextStyle(fontSize: 16),
                ),
                RangeSlider(
                  values: _selectedPriceRange,
                  min: 0.0,
                  max: 10000.0,
                  divisions: 100,
                  labels: RangeLabels(
                    '\$${_selectedPriceRange.start.toStringAsFixed(2)}',
                    '\$${_selectedPriceRange.end.toStringAsFixed(2)}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _selectedPriceRange = values;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final double stPrice = _selectedPriceRange.start;
                    final double enPrice = _selectedPriceRange.end;
                    print('ggg');
                    // تمرير القيم كـ double مباشرة
                    searchByPrice(stPrice, enPrice);
                  },
                  child: Text('Search by Price'),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _isSearchSuccess
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Center(
                                child: Journeycard(
                                  Icons: true,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JourneyShow(
                                            Id: _searchResults[index].id!),
                                      ),
                                    );
                                  },
                                  journey: _searchResults[index],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No data available')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
