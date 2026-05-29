import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:cached_network_image/cached_network_image.dart';
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/common_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editing = false;
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _cityCtrl;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().currentUser;
    _nameCtrl = TextEditingController(text: user?.name ?? '');
    _phoneCtrl = TextEditingController(text: user?.phone ?? '');
    _addressCtrl = TextEditingController(text: user?.address ?? '');
    _cityCtrl = TextEditingController(text: user?.city ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  Future<void> _saveProfile() async {
    await context.read<AuthViewModel>().updateProfile(
=======
  void _saveProfile() {
    context.read<AuthViewModel>().updateProfile(
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
          name: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          address: _addressCtrl.text.trim(),
          city: _cityCtrl.text.trim(),
        );
    setState(() => _editing = false);
<<<<<<< HEAD
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Profile updated'),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
=======
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile updated'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_editing) {
                _saveProfile();
              } else {
                setState(() => _editing = true);
              }
            },
            child: Text(
              _editing ? 'Save' : 'Edit',
              style: const TextStyle(
                  color: AppColors.accent, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (ctx, vm, _) {
          final user = vm.currentUser;
          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_off_outlined,
                      size: 60, color: AppColors.textLight),
                  const SizedBox(height: 16),
                  Text('Not signed in',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, AppRoutes.login),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
<<<<<<< HEAD
            child: Column(children: [
              _buildAvatar(user.name, user.photoUrl),
              const SizedBox(height: 28),
              _buildInfoSection(context),
              const SizedBox(height: 24),
              _buildMenuSection(context, vm),
            ]),
=======
            child: Column(
              children: [
                _buildAvatar(user.name),
                const SizedBox(height: 28),
                _buildInfoSection(context),
                const SizedBox(height: 24),
                _buildMenuSection(context, vm),
              ],
            ),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
          );
        },
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildAvatar(String name, String? photoUrl) {
    final initials = name
        .trim()
        .split(' ')
        .map((w) => w.isNotEmpty ? w[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    return Column(children: [
      // Show Google photo if available, else initials
      photoUrl != null && photoUrl.isNotEmpty
          ? CircleAvatar(
              radius: 44,
              backgroundImage: CachedNetworkImageProvider(photoUrl),
            )
          : Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 2),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ),
      const SizedBox(height: 12),
      Text(name, style: Theme.of(context).textTheme.displaySmall),
      Text(
        context.read<AuthViewModel>().currentUser?.email ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ]);
=======
  Widget _buildAvatar(String name) {
    final initials = name.trim().split(' ').map((w) => w.isNotEmpty ? w[0] : '').take(2).join().toUpperCase();
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.accent, width: 2),
          ),
          child: Center(
            child: Text(
              initials,
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(name, style: Theme.of(context).textTheme.displaySmall),
        Text(
          context.read<AuthViewModel>().currentUser?.email ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          if (_editing) ...[
            CustomTextField(
<<<<<<< HEAD
                label: 'Full Name', hint: 'Your name', controller: _nameCtrl),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'Phone',
                hint: '07X XXX XXXX',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'Address',
                hint: 'Street address',
                controller: _addressCtrl),
            const SizedBox(height: 16),
            CustomTextField(
                label: 'City', hint: 'Colombo', controller: _cityCtrl),
=======
              label: 'Full Name',
              hint: 'Your name',
              controller: _nameCtrl,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Phone',
              hint: '07X XXX XXXX',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Address',
              hint: 'Street address',
              controller: _addressCtrl,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'City',
              hint: 'Colombo',
              controller: _cityCtrl,
            ),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
          ] else ...[
            _infoRow(context, Icons.person_outline, 'Name',
                _nameCtrl.text.isEmpty ? '—' : _nameCtrl.text),
            _divider(),
            _infoRow(context, Icons.phone_outlined, 'Phone',
                _phoneCtrl.text.isEmpty ? '—' : _phoneCtrl.text),
            _divider(),
            _infoRow(context, Icons.location_on_outlined, 'Address',
                _addressCtrl.text.isEmpty ? '—' : _addressCtrl.text),
            _divider(),
            _infoRow(context, Icons.location_city_outlined, 'City',
                _cityCtrl.text.isEmpty ? '—' : _cityCtrl.text),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
<<<<<<< HEAD
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.accent),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.textLight)),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ]),
      ]),
    );
  }

  Widget _divider() => const Divider(height: 1, color: AppColors.divider);

  Widget _buildMenuSection(BuildContext context, AuthViewModel vm) {
    final items = [
      {'icon': Icons.shopping_bag_outlined, 'label': 'My Orders', 'onTap': () => Navigator.pushNamed(context, AppRoutes.orders)},
      {'icon': Icons.favorite_outline, 'label': 'Wishlist', 'onTap': () => Navigator.pushNamed(context, AppRoutes.wishlist)},
      {'icon': Icons.location_on_outlined, 'label': 'Saved Addresses', 'onTap': () => Navigator.pushNamed(context, AppRoutes.savedAddresses)},
      {'icon': Icons.notifications_outlined, 'label': 'Notifications', 'onTap': () => Navigator.pushNamed(context, AppRoutes.notifications)},
      {'icon': Icons.help_outline, 'label': 'Help & Support', 'onTap': () => Navigator.pushNamed(context, AppRoutes.helpSupport)},
    ];

    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: items.asMap().entries.map((e) {
            final item = e.value;
            return Column(children: [
              ListTile(
                leading: Icon(item['icon'] as IconData,
                    color: AppColors.textMid, size: 20),
                title: Text(item['label'] as String,
                    style: Theme.of(context).textTheme.bodyLarge),
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.textLight, size: 20),
                onTap: item['onTap'] as VoidCallback,
              ),
              if (e.key < items.length - 1)
                const Divider(height: 1, indent: 56, color: AppColors.divider),
            ]);
          }).toList(),
        ),
      ),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: ListTile(
          leading: const Icon(Icons.logout, color: AppColors.error, size: 20),
          title: Text('Sign Out',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.error)),
          onTap: () => _confirmLogout(context, vm),
        ),
      ),
      const SizedBox(height: 32),
    ]);
=======
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.accent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textLight)),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, color: AppColors.divider);

  Widget _buildMenuSection(BuildContext context, AuthViewModel vm) {
    final items = [
      {'icon': Icons.shopping_bag_outlined, 'label': 'My Orders', 'onTap': () {}},
      {'icon': Icons.favorite_outline, 'label': 'Wishlist', 'onTap': () {}},
      {'icon': Icons.location_on_outlined, 'label': 'Saved Addresses', 'onTap': () {}},
      {'icon': Icons.notifications_outlined, 'label': 'Notifications', 'onTap': () {}},
      {'icon': Icons.help_outline, 'label': 'Help & Support', 'onTap': () {}},
    ];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final item = e.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(item['icon'] as IconData,
                        color: AppColors.textMid, size: 20),
                    title: Text(item['label'] as String,
                        style: Theme.of(context).textTheme.bodyLarge),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textLight, size: 20),
                    onTap: item['onTap'] as VoidCallback,
                  ),
                  if (e.key < items.length - 1)
                    const Divider(
                        height: 1, indent: 56, color: AppColors.divider),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: ListTile(
            leading:
                const Icon(Icons.logout, color: AppColors.error, size: 20),
            title: Text('Sign Out',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.error)),
            onTap: () => _confirmLogout(context, vm),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  }

  void _confirmLogout(BuildContext context, AuthViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              vm.logout();
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
<<<<<<< HEAD
            child: const Text('Sign Out',
                style: TextStyle(color: AppColors.error)),
=======
            child:
                const Text('Sign Out', style: TextStyle(color: AppColors.error)),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
          ),
        ],
      ),
    );
  }
}
