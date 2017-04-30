from api.models import AppUser, Product, Stock, Cart, ProductCart
from api.serializers import AppUserSerializer, ProductSerializer, StockSerializer, CartSerializer, \
    ProductCartSerializer, AddProductToCartSerializer
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


# Create your views here.

class AppUserList(APIView):
    def get(self, request, format=None):
        appusers = AppUser.objects.all()
        serializer = AppUserSerializer(appusers, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = AppUserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AppUserDetail(APIView):
    def get_appuser(self, pk):
        try:
            return AppUser.objects.get(pk=pk)
        except AppUser.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        appuser = self.get_appuser(pk)
        serializer = AppUserSerializer(appuser)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        appuser = self.get_appuser(pk)
        serializer = AppUserSerializer(appuser, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductList(APIView):
    def get(self, request, format=None):
        products = Product.objects.all()
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        print (request.data)
        serializer = ProductSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductDetail(APIView):
    def get_product(self, pk):
        try:
            return Product.objects.get(pk=pk)
        except Product.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        product = Product.objects.get(pk=pk)
        serializer = ProductSerializer(product)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        product = self.get_product(pk)
        serializer = ProductSerializer(product, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductCartView(APIView):
    def get(self, request, pk, format=None):
        if AppUser.objects.filter(pk=pk).exists():
            if Cart.objects.filter(appuser_id=pk, purchased=False).exists() == False:
                tmp_cart = Cart()
                tmp_cart.appuser = AppUser.objects.get(pk=pk)
                tmp_cart.save()
            cart = Cart.objects.get(appuser_id=pk, purchased=False)
            serializer = CartSerializer(cart)
            return Response(serializer.data)
        else:
            raise Http404


    def post(self, request, pk, format=None):
        serializer = AddProductToCartSerializer(data=request.data)
        if serializer.is_valid():
            if AppUser.objects.filter(pk=pk).exists():
                if Cart.objects.filter(appuser_id=pk, purchased=False).exists() == False:
                    tmp_cart = Cart()
                    tmp_cart.appuser = AppUser.objects.get(pk=pk)
                    tmp_cart.save()
                if Product.objects.filter(pk=serializer.product_id).exists():
                    product = Product.objects.get(pk=serializer.product_id)
                    cart = Cart.objects.get(appuser_id=pk, purchased=False)
                    product_cart = ProductCart()
                    product_cart.product = product
                    product_cart.cart = cart
                    product_cart.quantity = serializer.quantity
                    product_cart.save()
                    cart_serializer = CartSerializer(cart)
                    return Response(cart_serializer)
                else:
                    return Response(data="Product not found", status=status.HTTP_206_PARTIAL_CONTENT)
            else:
                return Response(data="AppUser not found", status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
