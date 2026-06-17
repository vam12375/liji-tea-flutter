import '../data/sample_data.dart';
import '../models/tea_product.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<TeaProduct>> allProducts() async {
    return SampleData.allProducts;
  }

  Future<TeaProduct> featuredProduct() async {
    return SampleData.featured;
  }

  Future<TeaProduct?> productById(String id) async {
    return SampleData.productById(id);
  }

  Future<List<String>> categories() async {
    return SampleData.categories;
  }

  Future<List<TeaProduct>> productsByCategory(String category) async {
    return SampleData.productsByCategory(category);
  }

  Future<List<TeaProduct>> search(String keyword) async {
    final q = keyword.trim();
    if (q.isEmpty) return const [];
    return SampleData.allProducts
        .where((product) =>
            product.name.contains(q) ||
            product.category.contains(q) ||
            product.tagline.contains(q) ||
            product.origin.contains(q))
        .toList();
  }

  Future<List<String>> hotSearches() async {
    return SampleData.hotSearch;
  }
}
