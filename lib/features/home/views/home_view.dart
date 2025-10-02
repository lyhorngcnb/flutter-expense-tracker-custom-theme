import 'package:expensetracker/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/core/widgets/custom_card.dart';
import 'package:expensetracker/core/widgets/custom_button.dart';
import 'package:expensetracker/core/widgets/avatar_widget.dart';
import 'package:expensetracker/core/widgets/badge_widget.dart';
import 'package:expensetracker/core/widgets/section_header.dart';
import 'package:expensetracker/core/widgets/empty_state.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  final AuthController authController = Get.find();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/settings'),
            icon: Icon(Icons.settings_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: authController.logout,
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Card
              _buildProfileCard(context),

              const SizedBox(height: 24),

              // Balance Summary Cards
              _buildBalanceSummary(context),

              const SizedBox(height: 24),

              // Quick Actions
              SectionHeader(
                title: 'quick_actions'.tr,
              ),
              _buildQuickActions(context),

              const SizedBox(height: 24),

              // Recent Transactions
              SectionHeader(
                title: 'recent_transactions'.tr,
                actionText: 'view_all'.tr,
                onActionTap: () {
                  // Navigate to transactions page
                },
              ),
              _buildRecentTransactions(context),

              const SizedBox(height: 24),

              // Statistics Section
              SectionHeader(
                title: 'statistics'.tr,
              ),
              _buildStatistics(context),

              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.offAllNamed(AppRoutes.addexpense);
        },
        icon: Icon(Icons.add),
        label: Text('add_expense'.tr),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AvatarWidget(
            name: 'User Name',
            radius: 32,
            backgroundColor: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome_back'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomCard(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'expenses'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$2,450',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BadgeWidget(
                    text: '+12%',
                    backgroundColor: Colors.red.withOpacity(0.1),
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomCard(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'income'.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$3,820',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BadgeWidget(
                    text: '+8%',
                    backgroundColor: Colors.green.withOpacity(0.1),
                    textColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context,
              icon: Icons.add_circle_outline,
              label: 'add_expense'.tr,
              color: Theme.of(context).colorScheme.error,
              onTap: () {
                Get.offAllNamed(AppRoutes.addexpense);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              context,
              icon: Icons.trending_up,
              label: 'add_income'.tr,
              color: Colors.green,
              onTap: () {
                // Add income
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              context,
              icon: Icons.swap_horiz,
              label: 'transfer'.tr,
              color: Theme.of(context).colorScheme.primary,
              onTap: () {
                // Transfer
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap,
      }) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    // Check if there are transactions
    final hasTransactions = true; // Change this based on your data

    if (!hasTransactions) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: EmptyState(
          icon: Icons.receipt_long_outlined,
          title: 'no_transactions'.tr,
          message: 'start_tracking_message'.tr,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return CustomCard(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.zero,
          onTap: () {
            // View transaction details
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getCategoryColor(index).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getCategoryIcon(index),
                  color: _getCategoryColor(index),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTransactionTitle(index),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          _getTransactionCategory(index),
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Today',
                          style:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                _getTransactionAmount(index),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: index % 2 == 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatistics(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomCard(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'spending_by_category'.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCategoryBar(context, 'Food', 45, Colors.orange),
            const SizedBox(height: 12),
            _buildCategoryBar(context, 'Transport', 25, Colors.blue),
            const SizedBox(height: 12),
            _buildCategoryBar(context, 'Shopping', 20, Colors.purple),
            const SizedBox(height: 12),
            _buildCategoryBar(context, 'Others', 10, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBar(
      BuildContext context,
      String category,
      double percentage,
      Color color,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${percentage.toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  // Helper methods for demo data
  IconData _getCategoryIcon(int index) {
    final icons = [
      Icons.shopping_bag,
      Icons.restaurant,
      Icons.local_gas_station,
      Icons.movie,
      Icons.fitness_center,
    ];
    return icons[index % icons.length];
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Colors.orange,
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.green,
    ];
    return colors[index % colors.length];
  }

  String _getTransactionTitle(int index) {
    final titles = [
      'Shopping',
      'Restaurant',
      'Gas Station',
      'Cinema',
      'Gym Membership',
    ];
    return titles[index % titles.length];
  }

  String _getTransactionCategory(int index) {
    final categories = [
      'Shopping',
      'Food',
      'Transport',
      'Entertainment',
      'Health',
    ];
    return categories[index % categories.length];
  }

  String _getTransactionAmount(int index) {
    final amounts = ['-\$45.00', '+\$320.00', '-\$28.50', '-\$15.00', '-\$50.00'];
    return amounts[index % amounts.length];
  }
}