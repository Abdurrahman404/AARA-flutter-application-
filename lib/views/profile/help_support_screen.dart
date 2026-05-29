import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'q': 'How do I track my order?',
      'a':
          'Go to My Orders in your profile. Each order shows its current status: Pending, Confirmed, Shipped, or Delivered. You will also receive notifications as your order progresses.',
    },
    {
      'q': 'What is your return policy?',
      'a':
          'We accept returns within 14 days of delivery. Items must be unworn, unwashed, and in original condition with tags attached. Contact our support team to initiate a return.',
    },
    {
      'q': 'How long does delivery take?',
      'a':
          'Standard delivery takes 3–5 working days within Sri Lanka. Express delivery (1–2 days) is available for Colombo and suburbs. Free delivery on orders above Rs. 5,000.',
    },
    {
      'q': 'Can I change or cancel my order?',
      'a':
          'Orders can be cancelled or modified within 1 hour of placement. After that, the order may already be processed. Contact support immediately if you need changes.',
    },
    {
      'q': 'What payment methods do you accept?',
      'a':
          'We accept Credit/Debit Cards, Bank Transfer, and Cash on Delivery. All card payments are processed securely.',
    },
    {
      'q': 'How do I update my account details?',
      'a':
          'Go to your Profile screen and tap "Edit" in the top-right corner. You can update your name, phone number, address, and city.',
    },
    {
      'q': 'Are the product sizes true to size?',
      'a':
          'Our sizes follow standard Sri Lankan sizing. We recommend checking the size guide on each product page. If you\'re between sizes, we suggest sizing up.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact options
            _sectionTitle(context, 'Contact Us'),
            const SizedBox(height: 12),
            Row(
              children: [
                _contactCard(
                  context,
                  icon: Icons.chat_outlined,
                  label: 'Live Chat',
                  sub: 'Instant support',
                  onTap: () => _showSnack(context, 'Live chat coming soon'),
                ),
                const SizedBox(width: 12),
                _contactCard(
                  context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  sub: 'support@aara.lk',
                  onTap: () async {
                    final uri = Uri.parse('mailto:support@aara.lk');
                    if (await canLaunchUrl(uri)) launchUrl(uri);
                  },
                ),
                const SizedBox(width: 12),
                _contactCard(
                  context,
                  icon: Icons.phone_outlined,
                  label: 'Call Us',
                  sub: '+94 11 234 5678',
                  onTap: () async {
                    final uri = Uri.parse('tel:+94112345678');
                    if (await canLaunchUrl(uri)) launchUrl(uri);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            _sectionTitle(context, 'Frequently Asked Questions'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: _faqs.asMap().entries.map((e) {
                  final i = e.key;
                  final faq = e.value;
                  final isExpanded = _expandedIndex == i;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => setState(() =>
                            _expandedIndex = isExpanded ? null : i),
                        borderRadius: i == 0
                            ? const BorderRadius.vertical(
                                top: Radius.circular(16))
                            : i == _faqs.length - 1 && !isExpanded
                                ? const BorderRadius.vertical(
                                    bottom: Radius.circular(16))
                                : BorderRadius.zero,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  faq['q']!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: isExpanded
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: isExpanded
                                            ? AppColors.accent
                                            : AppColors.textDark,
                                      ),
                                ),
                              ),
                              AnimatedRotation(
                                turns: isExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.expand_more,
                                  color: isExpanded
                                      ? AppColors.accent
                                      : AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            faq['a']!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                ),
                          ),
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                      if (i < _faqs.length - 1)
                        const Divider(height: 1, color: AppColors.divider),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // About section
            _sectionTitle(context, 'About AARA'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  _aboutRow(context, Icons.info_outline, 'Version', '1.0.0'),
                  const Divider(height: 1, color: AppColors.divider),
                  _aboutRow(context, Icons.description_outlined,
                      'Terms of Service', '',
                      onTap: () =>
                          _showSnack(context, 'Terms of Service')),
                  const Divider(height: 1, color: AppColors.divider),
                  _aboutRow(context, Icons.privacy_tip_outlined,
                      'Privacy Policy', '',
                      onTap: () =>
                          _showSnack(context, 'Privacy Policy')),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Text(title,
      style: Theme.of(context).textTheme.displaySmall);

  Widget _contactCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String sub,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.accent, size: 26),
              const SizedBox(height: 8),
              Text(label,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text(sub,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textLight),
                  textAlign: TextAlign.center,
                  maxLines: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutRow(BuildContext context, IconData icon, String label,
      String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textMid),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            if (value.isNotEmpty)
              Text(value,
                  style: Theme.of(context).textTheme.bodyMedium),
            if (onTap != null)
              const Icon(Icons.chevron_right,
                  size: 18, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}
