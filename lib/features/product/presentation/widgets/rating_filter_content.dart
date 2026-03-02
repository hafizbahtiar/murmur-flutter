import 'package:flutter/material.dart';

class RatingFilterContent extends StatefulWidget {
  final int initialSelection;
  final int star5Count;
  final int star4Count;
  final int star3Count;
  final int star2Count;
  final int star1Count;
  final Function(int) onApply;

  const RatingFilterContent({
    super.key,
    required this.initialSelection,
    required this.star5Count,
    required this.star4Count,
    required this.star3Count,
    required this.star2Count,
    required this.star1Count,
    required this.onApply,
  });

  @override
  State<RatingFilterContent> createState() => _RatingFilterContentState();
}

class _RatingFilterContentState extends State<RatingFilterContent> {
  late int _tempSelection;

  @override
  void initState() {
    super.initState();
    _tempSelection = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFEE4D2D);

    return Column(
      children: [
        // Options List
        _buildRadioOption('All', 0, 0),
        _buildRadioOption('5 Star', 2, widget.star5Count),
        _buildRadioOption('4 Star', 3, widget.star4Count),
        _buildRadioOption('3 Star', 4, widget.star3Count),
        _buildRadioOption('2 Star', 5, widget.star2Count),
        _buildRadioOption('1 Star', 6, widget.star1Count),

        const SizedBox(height: 16),

        // Footer Buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _tempSelection = 0; // Default to 'All'
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Clear'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_tempSelection);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String label, int index, int count) {
    final isSelected = _tempSelection == index || (index == 0 && _tempSelection < 2 && _tempSelection != 1);
    const primaryColor = Color(0xFFEE4D2D);

    return InkWell(
      onTap: () {
        setState(() {
          _tempSelection = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
        ),
        child: Row(
          children: [
            // Custom Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? primaryColor : Colors.grey[400]!, width: isSelected ? 6 : 1),
              ),
            ),
            const SizedBox(width: 12),

            // Star Icons or Text
            if (index == 0)
              const Text('All', style: TextStyle(fontSize: 14))
            else
              Row(
                children: List.generate(5, (starIndex) {
                  // Logic to determine how many stars to color based on the row index
                  // index 2 = 5 stars, index 3 = 4 stars, etc.
                  // This maps 2->5, 3->4, 4->3, 5->2, 6->1
                  final starsToShow = 7 - index;

                  return Icon(
                    starIndex < starsToShow ? Icons.star : Icons.star_border,
                    color: starIndex < starsToShow ? const Color(0xFFFFC107) : Colors.grey[300],
                    size: 18,
                  );
                }),
              ),

            const Spacer(),

            if (index != 0) Text('($count)', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
