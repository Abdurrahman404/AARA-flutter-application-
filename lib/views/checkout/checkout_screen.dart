import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import '../../viewmodels/auth_viewmodel.dart';
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
import '../../viewmodels/cart_viewmodel.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/common_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _cityCtrl;
  final _zipCtrl = TextEditingController();
  int _paymentMethod = 0;
  bool _placingOrder = false;
=======
  final _nameCtrl = TextEditingController(text: 'Aisha Fernando');
  final _emailCtrl = TextEditingController(text: 'aisha@example.com');
  final _phoneCtrl = TextEditingController(text: '077 123 4567');
  final _addressCtrl = TextEditingController(text: '45, Galle Road');
  final _cityCtrl = TextEditingController(text: 'Colombo 03');
  final _zipCtrl = TextEditingController(text: '00300');
  int _paymentMethod = 0;
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4

  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': Icons.credit_card, 'label': 'Credit / Debit Card'},
    {'icon': Icons.account_balance_outlined, 'label': 'Bank Transfer'},
    {'icon': Icons.money, 'label': 'Cash on Delivery'},
  ];

  @override
<<<<<<< HEAD
  void initState() {
    super.initState();
    // Pre-fill from logged-in user profile
    final user = context.read<AuthViewModel>().currentUser;
    _nameCtrl = TextEditingController(text: user?.name ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
    _phoneCtrl = TextEditingController(text: user?.phone ?? '');
    _addressCtrl = TextEditingController(text: user?.address ?? '');
    _cityCtrl = TextEditingController(text: user?.city ?? '');
  }

  @override
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _zipCtrl.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final user = context.read<AuthViewModel>().currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please sign in to place an order')));
      return;
    }

    setState(() => _placingOrder = true);

    final cart = context.read<CartViewModel>();
    final paymentLabel = _paymentMethods[_paymentMethod]['label'] as String;

    final orderId = await cart.placeOrder(
      userId: user.id,
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      paymentMethod: paymentLabel,
    );

    if (!mounted) return;
    setState(() => _placingOrder = false);

    if (orderId != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.orderSuccess,
        (route) => route.settings.name == AppRoutes.home,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to place order. Try again.'),
        backgroundColor: AppColors.error,
      ));
    }
  }

=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _sectionTitle(context, 'Delivery Details'),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Full Name',
              hint: 'Your name',
              controller: _nameCtrl,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Email',
              hint: 'you@example.com',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Phone',
              hint: '07X XXX XXXX',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Address',
              hint: 'Street, No.',
              controller: _addressCtrl,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
<<<<<<< HEAD
            Row(children: [
              Expanded(
                flex: 2,
                child: CustomTextField(
                  label: 'City',
                  hint: 'Colombo',
                  controller: _cityCtrl,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  label: 'Postal Code',
                  hint: '00300',
                  controller: _zipCtrl,
                  keyboardType: TextInputType.number,
                ),
              ),
            ]),
            const SizedBox(height: 28),

=======
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    label: 'City',
                    hint: 'Colombo',
                    controller: _cityCtrl,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    label: 'Postal Code',
                    hint: '00300',
                    controller: _zipCtrl,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
            _sectionTitle(context, 'Payment Method'),
            const SizedBox(height: 16),
            ..._paymentMethods.asMap().entries.map((e) {
              final selected = _paymentMethod == e.key;
              return GestureDetector(
                onTap: () => setState(() => _paymentMethod = e.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.accent.withOpacity(0.05)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
<<<<<<< HEAD
                        color: selected ? AppColors.accent : AppColors.divider),
                  ),
                  child: Row(children: [
                    Icon(e.value['icon'] as IconData,
                        color: selected ? AppColors.accent : AppColors.textMid),
                    const SizedBox(width: 12),
                    Text(e.value['label'] as String,
=======
                        color: selected
                            ? AppColors.accent
                            : AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      Icon(e.value['icon'] as IconData,
                          color: selected
                              ? AppColors.accent
                              : AppColors.textMid),
                      const SizedBox(width: 12),
                      Text(
                        e.value['label'] as String,
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: selected
                                  ? AppColors.textDark
                                  : AppColors.textMid,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
<<<<<<< HEAD
                            )),
                    const Spacer(),
                    Icon(
                      selected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selected ? AppColors.accent : AppColors.textLight,
                    ),
                  ]),
                ),
              );
            }),

            const SizedBox(height: 28),
            _sectionTitle(context, 'Order Summary'),
            const SizedBox(height: 16),

=======
                            ),
                      ),
                      const Spacer(),
                      Icon(
                        selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: selected ? AppColors.accent : AppColors.textLight,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 28),
            _sectionTitle(context, 'Order Summary'),
            const SizedBox(height: 16),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
            Consumer<CartViewModel>(
              builder: (ctx, cart, _) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
<<<<<<< HEAD
                child: Column(children: [
                  ...cart.items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${item.product.name} × ${item.quantity}',
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text('Rs. ${(item.product.price * item.quantity).toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      )),
                  const Divider(color: AppColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(cart.formattedDelivery,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: cart.deliveryFee == 0
                                    ? AppColors.success
                                    : null,
                              )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(cart.formattedTotal,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.accent)),
                    ],
                  ),
                ]),
              ),
            ),

            const SizedBox(height: 32),

=======
                child: Column(
                  children: [
                    ...cart.items.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.product.name} × ${item.quantity}',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(item.formattedTotal,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        )),
                    const Divider(color: AppColors.divider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(cart.formattedDelivery,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: cart.deliveryFee == 0
                                          ? AppColors.success
                                          : null,
                                    )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          cart.formattedTotal,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
            Consumer<CartViewModel>(
              builder: (ctx, cart, _) => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
<<<<<<< HEAD
                  onPressed: _placingOrder ? null : _placeOrder,
                  child: _placingOrder
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text('Place Order · ${cart.formattedTotal}'),
=======
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cart.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.orderSuccess,
                        (route) => route.settings.name == AppRoutes.home,
                      );
                    }
                  },
                  child: Text(
                      'Place Order · ${cart.formattedTotal}'),
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _sectionTitle(BuildContext context, String title) =>
      Text(title, style: Theme.of(context).textTheme.displaySmall);
=======
  Widget _sectionTitle(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.displaySmall);
  }
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
}
