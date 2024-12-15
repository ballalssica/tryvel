import 'package:flutter/material.dart';
import 'package:tryvel/core/utils/validator_util.dart';

class OperatingHoursFormField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged; // 부모와 상태 동기화를 위한 콜백 추가

  const OperatingHoursFormField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _OperatingHoursFormFieldState createState() =>
      _OperatingHoursFormFieldState();
}

class _OperatingHoursFormFieldState extends State<OperatingHoursFormField> {
  String? _startTime; // 시작 시간
  String? _endTime; // 종료 시간

  @override
  void initState() {
    super.initState();
    // 컨트롤러 값에서 초기 시간 파싱
    final times = widget.controller.text.split('~');
    _startTime = times.isNotEmpty ? times[0].trim() : null;
    _endTime = times.length > 1 ? times[1].trim() : null;
  }

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

        // 부모 위젯에 변경 사항 알림
        if (widget.onChanged != null) {
          widget.onChanged!(widget.controller.text);
        }
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
                    decoration: const InputDecoration(
                      hintText: '시작 시간',
                      border: OutlineInputBorder(),
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
                    decoration: const InputDecoration(
                      hintText: '종료 시간',
                      border: OutlineInputBorder(),
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
