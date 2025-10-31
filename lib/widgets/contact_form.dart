import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_project/blocs/data_bloc.dart';
import 'package:sample_project/blocs/data_event.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/widgets/button.dart';
import 'package:sample_project/widgets/input.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final int? index;
  const ContactForm({super.key, this.contact, this.index});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstnameController;
  late final TextEditingController _lastnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _companyController;
  late final TextEditingController _linkedinController;

  File? _imageFile;

  @override
  void initState() {
    super.initState();

    final c = widget.contact; // shorthand

    _firstnameController = TextEditingController(text: c?.firstName ?? '');
    _lastnameController = TextEditingController(text: c?.lastName ?? '');
    _emailController = TextEditingController(text: c?.email ?? '');
    _phoneController = TextEditingController(text: c?.phoneNumber ?? '');
    _addressController = TextEditingController(text: c?.address ?? '');
    _companyController = TextEditingController(text: c?.company ?? '');
    _linkedinController = TextEditingController(text: c?.linkedIn ?? '');
    _imageFile = c?.imageUrl != null ? File(c!.imageUrl) : null;
  }

  @override
  void dispose() {
    for (final controller in [
      _firstnameController,
      _lastnameController,
      _emailController,
      _phoneController,
      _addressController,
      _companyController,
      _linkedinController,
    ]) {
      controller.dispose();
    }
    _imageFile?.delete();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() => _imageFile = File(picked.path));
  }

  Contact _buildContact() {
    return Contact(
      firstName: _firstnameController.text.trim(),
      lastName: _lastnameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      company: _companyController.text.trim(),
      linkedIn: _linkedinController.text.trim(),
      imageUrl:
          _imageFile?.path ??
          widget.contact?.imageUrl ??
          'assets/images/avatar.png',
      key: widget.contact?.key,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final newContact = _buildContact();
    final isUpdating = widget.contact != null && widget.index != null;

    final bloc = context.read<DataBloc>();
    bloc.add(
      isUpdating
          ? UpdateContact(newContact, widget.index!)
          : AddContact(newContact),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Contact ${isUpdating ? 'updated' : 'added'}: '
          '${newContact.firstName} ${newContact.lastName}',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightGreen.shade500,
        duration: const Duration(seconds: 2),
      ),
    );

    context.go('/');

    _formKey.currentState!.reset();
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.contact != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFC5C5C5), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAvatarSection(),
                  const SizedBox(height: 8),
                  _buildTextFields(),
                  const SizedBox(height: 16),
                  CustomButton(
                    onPressed: _submitForm,
                    text: isEditing ? 'Update Contact' : 'Add New Contact',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Color(0xFF5EBBC6),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              CustomInput(
                controller: _firstnameController,
                labelText: 'Firstname',
                validator: _requiredValidator,
              ),
              CustomInput(
                controller: _lastnameController,
                labelText: 'Lastname',
                validator: _requiredValidator,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        CustomInput(
          controller: _emailController,
          labelText: 'Email',
          validator: _emailValidator,
        ),
        CustomInput(controller: _phoneController, labelText: 'Phone'),
        CustomInput(controller: _addressController, labelText: 'Address'),
        CustomInput(controller: _companyController, labelText: 'Company'),
        CustomInput(controller: _linkedinController, labelText: 'LinkedIn'),
      ],
    );
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty) ? 'This field is required' : null;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an email';
    if (!value.contains('@')) return 'Enter a valid email';
    return null;
  }
}
