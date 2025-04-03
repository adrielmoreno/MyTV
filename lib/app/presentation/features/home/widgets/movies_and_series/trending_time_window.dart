import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../../../core/extensions/core_string_extensions.dart';

class TrendingTimeWindow extends StatelessWidget {
  const TrendingTimeWindow(
      {super.key, required this.timeWindow, required this.onChanged});
  final TimeWindow timeWindow;
  final void Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TRENDING',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DropdownButton<TimeWindow>(
                  value: timeWindow,
                  isDense: true,
                  items: TimeWindow.values
                      .map(
                        (e) => DropdownMenuItem<TimeWindow>(
                          value: e,
                          child: Text(e.name.capitalize()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null && value != timeWindow) {
                      onChanged(value);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
