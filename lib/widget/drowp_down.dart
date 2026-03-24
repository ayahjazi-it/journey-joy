import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/journey_activites_required_model.dart';

class MultiSelectDropdown extends StatefulWidget {
  final Future<List<ActiviyyRequiredModel>> Function(String token, int id)
  fetchActivities;
  final String token;
  final int journeyId;

  MultiSelectDropdown({
    required this.fetchActivities,
    required this.token,
    required this.journeyId,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<ActiviyyRequiredModel> _activities = [];
  List<ActiviyyRequiredModel> _selectedActivities = [];
  String _selectedActivitiesText = 'Select Activities';

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  void _loadActivities() async {
    try {
      final activities = await widget.fetchActivities(
        widget.token,
        widget.journeyId,
      );
      setState(() {
        _activities = activities;
      });
    } catch (e) {
      print('Error loading activities: $e');
    }
  }

  void _showMultiSelectDialog() async {
    final List<ActiviyyRequiredModel>? selectedValues =
        await showDialog<List<ActiviyyRequiredModel>>(
          context: context,
          builder: (BuildContext context) {
            return MultiSelectDialog(
              activities: _activities,
              selectedActivities: _selectedActivities,
            );
          },
        );

    if (selectedValues != null) {
      setState(() {
        _selectedActivities = selectedValues;
        _selectedActivitiesText = _selectedActivities.isNotEmpty
            ? _selectedActivities
                  .map((a) => a.activity_name ?? 'Unknown')
                  .join(', ')
            : 'Select Activities';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _showMultiSelectDialog,
            child: Text('Select Activities'),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedActivitiesText,
            items: [_selectedActivitiesText].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<ActiviyyRequiredModel> activities;
  final List<ActiviyyRequiredModel> selectedActivities;

  MultiSelectDialog({
    required this.activities,
    required this.selectedActivities,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<ActiviyyRequiredModel> _tempSelectedActivities = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedActivities = List.from(widget.selectedActivities);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Activities'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.activities.map((activity) {
            return CheckboxListTile(
              value: _tempSelectedActivities.contains(activity),
              title: Text(activity.activity_name ?? 'Unknown Activity'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    if (value) {
                      _tempSelectedActivities.add(activity);
                    } else {
                      _tempSelectedActivities.remove(activity);
                    }
                  });
                }
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
            Navigator.of(context).pop(_tempSelectedActivities);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
