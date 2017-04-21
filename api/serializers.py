from rest_framework import serializers
from api.models import AppUser, Product, Stock, Cart, ProductCart


class AppUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser
        fields = '__all__'


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        field = '__all__'


class StockSerializer(serializers.ModelSerializer):
    class Meta:
        model = Stock
        field = '__all__'


class ProductCartSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCart
        field = '__all__'


class CartSerializer(serializers.ModelSerializer):
    products = ProductCartSerializer(many=True, read_only=True)

    class Meta:
        model = Cart
        field = ('appuser', 'products', 'total_cost', 'purchased', 'payment')


