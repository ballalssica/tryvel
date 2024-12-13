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
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0); // 시작 시간 초기값
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0); // 종료 시간 초기값

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
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
            '${_startTime.format(context)} ~ ${_endTime.format(context)}';
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
                    keyboardType: TextInputType.number, // 숫자 전용 입력 스타일
                    decoration: InputDecoration(
                      labelText: '시작 시간',
                      hintText: _startTime.format(context),
                      border: const OutlineInputBorder(),
                    ),
                    validator: ValidatorUtil
                        .validatoroperatingHours, // ValidatorUtil 사용
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
                    keyboardType: TextInputType.number, // 숫자 전용 입력 스타일
                    decoration: InputDecoration(
                      labelText: '종료 시간',
                      hintText: _endTime.format(context),
                      border: const OutlineInputBorder(),
                    ),
                    validator: ValidatorUtil
                        .validatoroperatingHours, // ValidatorUtil 사용
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 입력된 시간 출력
        if (widget.controller.text.isNotEmpty)
          Text(
            '운영시간: ${widget.controller.text}',
            style: const TextStyle(color: Colors.green),
          ),
      ],
    );
  }
}
