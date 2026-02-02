import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final void Function()? onEdit;
  final void Function()? onDelete;
  final String title;
  final String description;
  final String duration;
  TaskCard({
    super.key,
    this.onEdit,
    this.onDelete,
    required this.title,
    required this.description,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBCB8B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFEBCB8B).withOpacity(0.5),
                  ),
                ),
                child: const Text(
                  'In-Progress',
                  style: TextStyle(
                    color: Color(0xFFEBCB8B),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Task',
            style: TextStyle(color: Color(0xFF8F73F8), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Time Required',
            style: TextStyle(color: Color(0xFF8F73F8), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            duration,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Description',
            style: TextStyle(color: Color(0xFF8F73F8), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
