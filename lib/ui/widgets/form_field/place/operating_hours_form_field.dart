import 'package:flutter/material.dart';

class OperatingHoursFormField extends StatefulWidget {
  final TextEditingController controller; // 컨트롤러 추가

  const OperatingHoursFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  _OperatingHoursFormFieldState createState() =>
      _OperatingHoursFormFieldState();
}

class _OperatingHoursFormFieldState extends State<OperatingHoursFormField> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }

        // 컨트롤러에 값 저장
        widget.controller.text =
            '${_startTime?.format(context) ?? ''} ~ ${_endTime?.format(context) ?? ''}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '시작 시간',
                      hintText: _startTime == null
                          ? '예: 09:00'
                          : _startTime!.format(context),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '종료 시간',
                      hintText: _endTime == null
                          ? '예: 18:00'
                          : _endTime!.format(context),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
