class Product {
  final String affiliateUrl;
  final String brand;
  final String brandId;
  final String category;
  final String category1;
  final String category2;
  final String description;
  final int discountPercentage;
  final bool hasImage;
  final String id;
  final String image;
  final String imageMerchant;
  final double listPrice;
  final String merchant;
  final String merchantId;
  final bool newOffer;
  final double sellingPrice;
  final List<String> tags;
  final String title;
  final String url;
  final bool? isMerchantCard;
  final String? merchantToken;

  Product({
    required this.affiliateUrl,
    required this.brand,
    required this.brandId,
    required this.category,
    required this.category1,
    required this.category2,
    required this.description,
    required this.discountPercentage,
    required this.hasImage,
    required this.id,
    required this.image,
    required this.imageMerchant,
    required this.listPrice,
    required this.merchant,
    required this.merchantId,
    required this.newOffer,
    required this.sellingPrice,
    required this.tags,
    required this.title,
    required this.url,
    this.isMerchantCard,
    this.merchantToken,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      affiliateUrl: json['affiliate_url'],
      brand: json['brand'],
      brandId: json['brandId'],
      category: json['category'],
      category1: json['category_1'],
      category2: json['category_2'],
      description: json['description'],
      discountPercentage: json['discount_percentage'],
      hasImage: json['has_image'] == 1,
      id: json['id'],
      image: json['image'],
      imageMerchant: json['image_merchant'],
      listPrice: (json['list_price'] as num).toDouble(),
      merchant: json['merchant'],
      merchantId: json['merchantId'],
      newOffer: json['new_offer'],
      sellingPrice: (json['selling_price'] as num).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      title: json['title'],
      url: json['url'],
      isMerchantCard: json['isMerchantCard'] ?? false,
      merchantToken: json['merchantToken'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'affiliate_url': affiliateUrl,
      'brand': brand,
      'brandId': brandId,
      'category': category,
      'category_1': category1,
      'category_2': category2,
      'description': description,
      'discount_percentage': discountPercentage,
      'has_image': hasImage ? 1 : 0,
      'id': id,
      'image': image,
      'image_merchant': imageMerchant,
      'list_price': listPrice,
      'merchant': merchant,
      'merchantId': merchantId,
      'new_offer': newOffer,
      'selling_price': sellingPrice,
      'tags': tags,
      'title': title,
      'url': url,
      'isMerchantCard': isMerchantCard,
      'merchantToken': merchantToken,
    };
  }
}
