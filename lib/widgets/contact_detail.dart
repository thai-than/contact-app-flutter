import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/utils/constant.dart';
import 'package:sample_project/utils/image_utils.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                // Avatar
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: getImageProvider(contact.imageUrl),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Name
                Text(
                  contact.fullName,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  contact.phoneNumber,
                  style: const TextStyle(
                    color: kTextDarkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: kTextLightColor, height: 1),
                const SizedBox(height: 20),
                _infoRow(Icons.email, contact.email ?? ""),
                const SizedBox(height: 20),
                _infoRow(Icons.location_on, contact.address ?? ""),
                const SizedBox(height: 20),
                _infoRow(Icons.business, contact.company ?? ""),
                const SizedBox(height: 20),
                _infoRow(Icons.link, contact.website ?? ""),
                const SizedBox(height: 20),

                // QR Code qr_flutter
                Center(
                  child: QrImageView(
                    data: contact.toStringJSON(),
                    version: QrVersions.auto,
                    size: 120,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: kTextDarkColor, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kTextDarkColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
