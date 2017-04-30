from rest_framework import serializers
from api.models import AppUser, Product, Stock, Cart, ProductCart


class AppUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser
        fields = '__all__'


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class StockSerializer(serializers.ModelSerializer):
    class Meta:
        model = Stock
        fields = '__all__'


class ProductCartSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCart
        fields = '__all__'


class CartSerializer(serializers.ModelSerializer):
    products = ProductCartSerializer(many=True, read_only=True)

    class Meta:
        model = Cart
        fields = ('appuser', 'products', 'total_cost', 'purchased', 'payment')


class AddProductToCartSerializer(serializers.Serializer):
    product_id = serializers.IntegerField()
    quantity = serializers.IntegerField(max_value=3)
