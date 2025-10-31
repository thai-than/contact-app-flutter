import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/utils/image_utils.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactCard({super.key, required this.contact, required this.index});

  void onCardTap(BuildContext context) {
    context.go('/contact/$index', extra: contact);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCardTap(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // inner spacing
          child: Row(
            children: [
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: getImageProvider(contact.imageUrl),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Text section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact.email,
                      style: const TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
