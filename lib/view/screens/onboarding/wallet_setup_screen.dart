import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/user_preferences_service.dart';
import '../../../themes/colors.dart';
import '../../widgets/bottom_navigation.dart';

class WalletSetupScreen extends StatefulWidget {
  static const String id = 'wallet_setup_screen';

  const WalletSetupScreen({super.key});

  @override
  WalletSetupScreenState createState() => WalletSetupScreenState();
}

class WalletSetupScreenState extends State<WalletSetupScreen> {
  final TextEditingController _walletController = TextEditingController();
  final TextEditingController _privateKeyController = TextEditingController(); // Controller cho private key
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isLoading = false;
  bool _isWalletValid = true;
  bool _showPrivateKey = false; // Ẩn/hiện private key
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  final _walletFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkExistingData();
  }
  Future<void> _checkExistingData() async {
    setState(() {
      _isLoading = true;
    });

    final walletAddress = await UserPreferencesService.getWalletAddress();
    final walletPrivateKey = await UserPreferencesService.getWalletPrivateKey();
    final name = await UserPreferencesService.getUserName();
    final phone = await UserPreferencesService.getUserPhone();
    final address = await UserPreferencesService.getShippingAddress();
    final city = await UserPreferencesService.getUserCity();

    if (walletAddress != null && walletAddress.isNotEmpty) {
      _walletController.text = walletAddress;
    }
    
    if (walletPrivateKey != null && walletPrivateKey.isNotEmpty) {
      _privateKeyController.text = walletPrivateKey;
    }

    if (name != null) _nameController.text = name;
    if (phone != null) _phoneController.text = phone;
    if (address != null) _addressController.text = address;
    if (city != null) _cityController.text = city;

    // If wallet address exists, move to step 2
    if (walletAddress != null && walletAddress.isNotEmpty) {
      setState(() {
        _currentStep = 1;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }
  @override
  void dispose() {
    _walletController.dispose();
    _privateKeyController.dispose(); // Giải phóng controller mới
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildStepIndicator(),
          const SizedBox(height: 30),
          _currentStep == 0 ? _buildWalletForm() : _buildUserInfoForm(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.mainColor, AppColors.mainColor.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet,
                  color: Colors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _currentStep == 0
                      ? 'Setup Your Wallet'
                      : 'Shipping Information',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _currentStep == 0
                ? 'To continue shopping on RevMe Shop, you need an Ethereum wallet address. This helps us process your transactions securely.'
                : 'Please provide your shipping details so we can deliver your purchases.',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStepCircle(0, 'Wallet Setup'),
          _buildStepDivider(),
          _buildStepCircle(1, 'Personal Info'),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    final isActive = _currentStep >= step;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.mainColor : Colors.grey.shade300,
              border: Border.all(
                color: isActive ? AppColors.mainColor : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${step + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.mainColor : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 60,
      height: 2,
      color: _currentStep > 0 ? AppColors.mainColor : Colors.grey.shade300,
    );
  }

  Widget _buildWalletForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _walletFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 30),
            Text(
              'Your Ethereum Wallet Address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 10),            TextFormField(
              controller: _walletController,
              decoration: InputDecoration(
                hintText: '0x...',
                prefixIcon: const Icon(Icons.account_balance_wallet),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.content_paste),
                  onPressed: () async {
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data != null && data.text != null) {
                      _walletController.text = data.text!;
                      _validateWalletAddress(data.text!);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: !_isWalletValid
                    ? 'Invalid wallet address. Format must be 0x + 40 hex characters'
                    : null,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your wallet address';
                }
                if (!UserPreferencesService.isValidEthereumAddress(value)) {
                  return 'Invalid wallet address';
                }
                return null;
              },
              onChanged: _validateWalletAddress,
            ),
            const SizedBox(height: 20),
              // Private Key field
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Your Ethereum Private Key (Optional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Your private key is sensitive information. Never share it with others.',
                  child: Icon(Icons.info_outline, color: Colors.red.shade300, size: 20),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.red.shade400, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Security warning: Store your private key securely. Never share it with anyone.',
                      style: TextStyle(fontSize: 12, color: Colors.red.shade900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _privateKeyController,
              obscureText: !_showPrivateKey,
              decoration: InputDecoration(
                hintText: '0x...',
                prefixIcon: const Icon(Icons.key),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(_showPrivateKey ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _showPrivateKey = !_showPrivateKey;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.content_paste),
                      onPressed: () async {
                        final data = await Clipboard.getData(Clipboard.kTextPlain);
                        if (data != null && data.text != null) {
                          _privateKeyController.text = data.text!;
                        }
                      },
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Private key is optional, không cần validator
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitWalletAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDontHaveWallet(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade700),
              const SizedBox(width: 10),
              Text(
                'Important Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Your Ethereum wallet address will be used to process purchases on RevMe Shop. Make sure you enter the correct address and have access to it.',
            style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
          ),
        ],
      ),
    );
  }

  Widget _buildDontHaveWallet() {
    return Center(
      child: TextButton(
        onPressed: () {
          _showCreateWalletInfo();
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            children: const [
              TextSpan(text: 'Don\'t have an Ethereum wallet? '),
              TextSpan(
                text: 'Learn how to create one',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateWalletInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How to Create an Ethereum Wallet'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildWalletOption(
                'MetaMask',
                'Most popular wallet, easy to use',
                Icons.security,
                Colors.orange,
              ),
              const Divider(),
              _buildWalletOption(
                'Trust Wallet',
                'Versatile wallet from Binance',
                Icons.shield,
                Colors.blue,
              ),
              const Divider(),
              _buildWalletOption(
                'Coinbase Wallet',
                'Wallet from Coinbase exchange',
                Icons.account_balance,
                Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                'After creating your wallet, return here and enter your Ethereum address to continue.',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletOption(
      String name, String desc, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^\d{9,11}$').hasMatch(value)) {
                  return 'Invalid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _addressController,
              label: 'Address Details',
              icon: Icons.home,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _cityController,
              label: 'City',
              icon: Icons.location_city,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentStep = 0;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: AppColors.mainColor),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitUserInfo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Complete',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  void _validateWalletAddress(String value) {
    setState(() {
      _isWalletValid =
          value.isEmpty || UserPreferencesService.isValidEthereumAddress(value);
    });
  }
  Future<void> _submitWalletAddress() async {
    if (_walletFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Lưu địa chỉ ví
      await UserPreferencesService.saveWalletAddress(_walletController.text);
      
      // Lưu private key (nếu có)
      if (_privateKeyController.text.isNotEmpty) {
        await UserPreferencesService.saveWalletPrivateKey(_privateKeyController.text);
      }

      setState(() {
        _isLoading = false;
        _currentStep = 1;
      });
    }
  }

  Future<void> _submitUserInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Save user information
        await UserPreferencesService.saveUserInfo(
          name: _nameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          city: _cityController.text,
        );

        // Mark onboarding as complete
        await UserPreferencesService.setOnboardingComplete();

        if (mounted) {
          // Navigate to product list screen
          // Navigator.pushReplacementNamed(context, ListProductScreen.id);
          // CustomBottomNavigationBar
          Navigator.pushReplacementNamed(context, CustomBottomNavigationBar.id);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }
}
