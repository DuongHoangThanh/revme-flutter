import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/view/screens/blockchain/transaction_history_screen.dart';
import 'package:web3dart/web3dart.dart';
import '../../../core/enum/product_category.dart';
import '../../../core/models/product.dart';
import '../../../core/services/blockchain_service.dart';
import '../../../viewmodels/product_viewmodel.dart';
import '../../../themes/colors.dart';
import 'cart_screen.dart';

class ListProductScreen extends StatefulWidget {
  static const String id = 'list_product_screen';

  const ListProductScreen({Key? key}) : super(key: key);

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  late ProductViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Create blockchain service without trying to connect immediately
    final blockchainService = BlockchainService();

    // Initialize viewmodel
    _viewModel = ProductViewModel(blockchainService: blockchainService);
    // Load products
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: const ProductListView(),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'RevMe Shop',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            tooltip: 'Cart',
            onPressed: () {
              // Navigate to cart screen
              Navigator.pushNamed(context, CartScreen.id);
            },
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Transaction History',
            onPressed: () {
              // Navigate to cart screen
              Navigator.pushNamed(context, TransactionHistoryScreen.id);
            },
          ),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error.isNotEmpty && viewModel.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${viewModel.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.init(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 8),
                  _buildBalanceCard(viewModel),
                  const SizedBox(height: 16),
                  _buildCategoryFilter(context, viewModel),
                  const SizedBox(height: 16),
                  Expanded(
                    child: viewModel.products.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_basket,
                                    size: 64, color: Colors.grey),
                                const SizedBox(height: 16),
                                const Text('No products available'),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () => viewModel.fetchProducts(),
                                  child: const Text('Refresh'),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await viewModel.fetchProducts();
                            },
                            child: ListView.builder(
                              itemCount: viewModel.products.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (context, index) {
                                return _buildProductItem(context,
                                    viewModel.products[index], viewModel);
                              },
                            ),
                          ),
                  ),
                ],
              ),

              // Show loading overlay for blockchain operations
              if (viewModel.isBlockchainLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        Text(
                          'Processing Blockchain Transaction',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please wait...',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard(ProductViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.mainColor, Color(0xFFFFA53E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!viewModel.isBlockchainConnected)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Offline Mode',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Wallet address row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${viewModel.userAddress.substring(0, 6)}...${viewModel.userAddress.substring(viewModel.userAddress.length - 4)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => viewModel.connectToBlockchain(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.mainColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                    viewModel.isBlockchainConnected ? 'Refresh' : 'Connect'),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Colors.white24),
          const SizedBox(height: 16),

          // ETH Balance only
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.currency_bitcoin,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ETH Balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatEthBalance(viewModel.ethBalance.toString()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Add this helper function to the _ListProductScreenState class
  String _formatEthBalance(String ethBalance) {
    // Extract the numeric part (assuming format like "0.123456 ETH")
    final parts = ethBalance.split(' ');
    if (parts.isEmpty) return ethBalance;

    final numericPart = parts[0];

    try {
      final value = double.parse(numericPart);

      // Format based on size
      String formatted;
      if (value >= 1000) {
        // For large values, show fewer decimals
        formatted = value.toStringAsFixed(2);
      } else if (value >= 100) {
        formatted = value.toStringAsFixed(3);
      } else if (value >= 1) {
        formatted = value.toStringAsFixed(4);
      } else {
        // For small values, keep 5-6 decimal places
        formatted = value.toStringAsFixed(6);
      }

      // Remove trailing zeros after decimal point
      if (formatted.contains('.')) {
        formatted = formatted.replaceAll(RegExp(r'0+$'), '');
        formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      }

      return '$formatted ETH';
    } catch (e) {
      return ethBalance; // Return original if parsing fails
    }
  }

  // Format BigInt to a readable number with appropriate decimal places
  String _formatBigInt(BigInt value) {
    // Convert from wei (18 decimals) to a readable token amount
    final decimal = value % BigInt.from(1000000000000000000);
    final integer = value ~/ BigInt.from(1000000000000000000);

    if (decimal == BigInt.zero) {
      return integer.toString();
    }

    // Format with up to 4 decimal places
    String decimalStr = decimal.toString().padLeft(18, '0');
    decimalStr = decimalStr.substring(0, 4);
    return '$integer.$decimalStr';
  }

  Widget _buildCategoryFilter(
      BuildContext context, ProductViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _categoryChip(
            context,
            null,
            'All',
            Icons.shopping_bag,
            viewModel.selectedCategory == null,
            () => viewModel.filterByCategory(null),
          ),
          const SizedBox(width: 12),
          _categoryChip(
            context,
            ProductCategory.food,
            'Food',
            Icons.fastfood,
            viewModel.selectedCategory == ProductCategory.food,
            () => viewModel.filterByCategory(ProductCategory.food),
          ),
          const SizedBox(width: 12),
          _categoryChip(
            context,
            ProductCategory.equipment,
            'Equipment',
            Icons.fitness_center,
            viewModel.selectedCategory == ProductCategory.equipment,
            () => viewModel.filterByCategory(ProductCategory.equipment),
          ),
          const SizedBox(width: 12),
          _categoryChip(
            context,
            ProductCategory.medicine,
            'Medicine',
            Icons.medical_services,
            viewModel.selectedCategory == ProductCategory.medicine,
            () => viewModel.filterByCategory(ProductCategory.medicine),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(
    BuildContext context,
    ProductCategory? category,
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
      BuildContext context, Product product, ProductViewModel viewModel) {
    final categoryIcon = _getCategoryIcon(product.category);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              product.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(product.category),
                        size: 64,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(product.category)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            categoryIcon,
                            size: 16,
                            color: _getCategoryColor(product.category),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.category.toString().split('.').last,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(product.category),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (!product.isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Out of Stock',
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ETH price only
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.currency_bitcoin,
                              size: 18, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text(
                            '${_formatEthAmount(product.ethPrice)} ETH',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ETH purchase button only
                    ElevatedButton.icon(
                      onPressed: product.isActive
                          ? () => _showPurchaseDialog(
                              context, product, viewModel, true)
                          : null,
                      icon: const Icon(Icons.shopping_cart_checkout, size: 18),
                      label: const Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPurchaseDialog(
    BuildContext context,
    Product product,
    ProductViewModel viewModel,
    bool useEth,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to purchase ${product.name}?'),
            const SizedBox(height: 12),
            Text(
              'Price: ${useEth ? "${_formatEthAmount(product.ethPrice)} ETH" : ""}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (!viewModel.isBlockchainConnected) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.amber),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You are in offline mode. The app will try to connect to the blockchain when you confirm.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await viewModel.purchaseProduct(product, useEth);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.message),
                    backgroundColor: result.success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(ProductCategory category) {
    switch (category) {
      case ProductCategory.food:
        return Icons.fastfood;
      case ProductCategory.equipment:
        return Icons.fitness_center;
      case ProductCategory.medicine:
        return Icons.medical_services;
    }
  }

  Color _getCategoryColor(ProductCategory category) {
    switch (category) {
      case ProductCategory.food:
        return Colors.green;
      case ProductCategory.equipment:
        return Colors.blue;
      case ProductCategory.medicine:
        return Colors.purple;
    }
  }

  String _formatEthAmount(BigInt amount) {
    // Convert from wei to ether
    final etherValue = EtherAmount.fromBigInt(EtherUnit.wei, amount)
        .getValueInUnit(EtherUnit.ether);

    // Format to 6 decimal places
    return etherValue.toStringAsFixed(6);
  }
}
