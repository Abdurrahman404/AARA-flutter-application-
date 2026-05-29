import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/common_widgets.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _fetchAddresses(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();
    if (data == null) return [];
    final raw = data['savedAddresses'] as List<dynamic>? ?? [];
    return raw.cast<Map<String, dynamic>>();
  }

  Future<void> _saveAddresses(
      String uid, List<Map<String, dynamic>> addresses) async {
    await _db
        .collection('users')
        .doc(uid)
        .set({'savedAddresses': addresses}, SetOptions(merge: true));
  }

  void _showAddDialog(
      BuildContext context, String uid, List<Map<String, dynamic>> current) {
    final labelCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Address',
                      style: Theme.of(context).textTheme.displaySmall),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Label (e.g. Home, Work)',
                hint: 'Home',
                controller: labelCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Full Name',
                hint: 'Your name',
                controller: nameCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Phone',
                hint: '07X XXX XXXX',
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'Address',
                hint: 'Street, No.',
                controller: addressCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: 'City',
                hint: 'Colombo',
                controller: cityCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final updated = [
                      ...current,
                      {
                        'label': labelCtrl.text.trim(),
                        'name': nameCtrl.text.trim(),
                        'phone': phoneCtrl.text.trim(),
                        'address': addressCtrl.text.trim(),
                        'city': cityCtrl.text.trim(),
                      }
                    ];
                    await _saveAddresses(uid, updated);
                    if (!mounted) return;
                    Navigator.pop(ctx);
                    setState(() {});
                  },
                  child: const Text('Save Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthViewModel>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Addresses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: user == null
          ? Center(
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text('Sign In'),
              ),
            )
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchAddresses(user.id),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.accent));
                }
                final addresses = snap.data ?? [];
                return Stack(
                  children: [
                    addresses.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_off_outlined,
                                    size: 72, color: AppColors.divider),
                                const SizedBox(height: 16),
                                Text('No saved addresses',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                const SizedBox(height: 8),
                                Text('Add your delivery addresses here',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                            itemCount: addresses.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (ctx, i) {
                              final a = addresses[i];
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: AppColors.divider),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.accent.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                          Icons.location_on_outlined,
                                          color: AppColors.accent,
                                          size: 20),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            a['label'] ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(a['name'] ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          if ((a['phone'] ?? '')
                                              .isNotEmpty)
                                            Text(a['phone'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                          Text(
                                            '${a['address']}, ${a['city']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          size: 18, color: AppColors.error),
                                      onPressed: () async {
                                        final updated = List<
                                                Map<String, dynamic>>.from(
                                            addresses)
                                          ..removeAt(i);
                                        await _saveAddresses(
                                            user.id, updated);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    Positioned(
                      bottom: 24,
                      left: 20,
                      right: 20,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _showAddDialog(context, user.id, addresses),
                        icon: const Icon(Icons.add),
                        label: const Text('Add New Address'),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
