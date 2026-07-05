import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart'; // للتأكد من استخدام kPrimaryColor

class QuantityCounter extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const QuantityCounter({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 160, // تحديد عرض مناسب متناسق مع الصورة
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300], // خلفية الرمادي الفاتح
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // زر النقصان (-)
              Expanded(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  onTap: value > 1
                      ? () => onChanged(value - 1)
                      : null, // يمنع النزول عن 1
                  child: const Center(
                    child: Icon(Icons.remove, color: Colors.black87, size: 20),
                  ),
                ),
              ),

              // رقم العداد (1)
              Expanded(
                child: Center(
                  child: Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              // زر الزيادة (+) الملون بلون الهوية الأخضر
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    4.0,
                  ), // مسافة بسيطة ليعطي شكل مربع منفصل داخل الحاوية
                  child: InkWell(
                    onTap: () => onChanged(value + 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            kPrimaryColor, // اللون الأخضر الخاص بكم #097622 أو #4caf50
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
