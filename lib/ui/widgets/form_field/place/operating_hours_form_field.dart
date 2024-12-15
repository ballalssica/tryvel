import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class OperatingHoursFormField extends StatefulWidget {
  final TextEditingController controller;

  const OperatingHoursFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  _OperatingHoursFormFieldState createState() =>
      _OperatingHoursFormFieldState();
}

class _OperatingHoursFormFieldState extends State<OperatingHoursFormField> {
  String? _startTime; // 시작 시간 초기값 없음
  String? _endTime; // 종료 시간 초기값 없음

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        final formattedTime = _formatTime(pickedTime);
        if (isStartTime) {
          _startTime = formattedTime;
        } else {
          _endTime = formattedTime;
        }

        // 컨트롤러에 값 저장
        widget.controller.text = '${_startTime ?? ''} ~ ${_endTime ?? ''}';
      });
    }
  }

  // TimeOfDay를 00:00 형식의 문자열로 변환
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
                    controller: TextEditingController(text: _startTime ?? ''),
                    decoration: InputDecoration(
                      hintText: '시작 시간',
                      border: const OutlineInputBorder(),
                    ),
                    validator: ValidatorUtil.validatoroperatingHoursStart,
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
                    controller: TextEditingController(text: _endTime ?? ''),
                    decoration: InputDecoration(
                      hintText: '종료 시간',
                      border: const OutlineInputBorder(),
                    ),
                    validator: ValidatorUtil.validatoroperatingHoursEnd,
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
