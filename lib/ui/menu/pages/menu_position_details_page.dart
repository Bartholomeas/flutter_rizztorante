import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/ui/menu/models/menu_position_details_model.dart';

class MenuPositionDetailsPage extends StatefulWidget {
  final String positionId;

  const MenuPositionDetailsPage({super.key, required this.positionId});

  @override
  State<MenuPositionDetailsPage> createState() =>
      _MenuPositionDetailsPageState();
}

class _MenuPositionDetailsPageState extends State<MenuPositionDetailsPage> {
  final _apiProvider = ApiProvider();
  MenuPositionDetails? _details;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final response =
          await _apiProvider.getMenuPositionDetails(widget.positionId);
      setState(() {
        _details = MenuPositionDetails.fromJson(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Szczegóły pozycji'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Nie mogliśmy znaleźć informacji na temat tego produktu',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ),
      );
    }

    if (_details == null) {
      return const Center(child: Text('No data available'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_details?.menuPosition.coreImage?.url != null)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Image.network(
                _details!.menuPosition.coreImage!.url,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.restaurant,
                            size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(
                          'Brak zdjęcia',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _details!.menuPosition.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${(_details!.menuPosition.price / 100).toStringAsFixed(2)} PLN',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                if (_details!.menuPosition.description != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _details!.menuPosition.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
                if (_details?.longDescription != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _details!.longDescription!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    if (_details!.menuPosition.isVegetarian)
                      _buildTag('Wege', Colors.green),
                    if (_details!.menuPosition.isVegan)
                      _buildTag('Vegan', Colors.green[700]!),
                    if (_details!.menuPosition.isGlutenFree)
                      _buildTag('Bezglutenowe', Colors.blue),
                  ],
                ),
                if (_details?.nutritionalInfo != null ||
                    _details?.calories != null) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Wartości odżywcze',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (_details?.calories != null)
                    Text('Kalorie: ${_details!.calories} kcal'),
                  if (_details?.nutritionalInfo?.protein != null)
                    Text('Białka: ${_details!.nutritionalInfo!.protein}g'),
                  if (_details?.nutritionalInfo?.carbs != null)
                    Text('Węglowodany: ${_details!.nutritionalInfo!.carbs}g'),
                  if (_details?.nutritionalInfo?.fat != null)
                    Text('Tłuszcze: ${_details!.nutritionalInfo!.fat}g'),
                ],
                if (_details!.allergens.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Alergeny',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _details!.allergens
                        .map((allergen) => _buildTag(
                              allergen,
                              Colors.red[300]!,
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
