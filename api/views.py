import json
from api.models import AppUser, Product, Stock, Cart, ProductCart
from django.contrib.auth.models import User
from api.serializers import ProductSerializer, StockSerializer, CartSerializer, \
    ProductCartSerializer, CartProductSerializer, PurchasedCartSerializer, UserSerializer, CreateUserSerializer
from django.http import Http404, JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAuthenticated, IsAdminUser, AllowAny
from oauth2_provider.contrib.rest_framework import TokenHasReadWriteScope, TokenHasScope


# Create your views here.

class CreateUserView(APIView):
    permission_classes = (AllowAny, )

    def post(self, request, format=None):
        user = User.objects.create_user(
            username=request.data['username'], password=request.data['password'], email=request.data['email'])
        serializer = CreateUserSerializer(data=user)
        if serializer.is_valid():
            return Response(data=serializer.data, status=status.HTTP_201_CREATED)
        else:
            raise Http404


class ProductList(APIView):
    permission_classes = (AllowAny, )

    def get(self, request, format=None):
        products = Product.objects.all()
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        print(request.data)
        serializer = ProductSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ProductSearchByUPC(APIView):
    permission_classes = (AllowAny, )

    def get(self, request, barcode, format=None):
        product = Product.objects.get(code=barcode)
        serializer = ProductSerializer(product)
        return Response(serializer.data)


class ProductDetail(APIView):
    permission_classes = (IsAuthenticatedOrReadOnly,)

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
    permission_classes = (AllowAny,)

    def get(self, request, format=None):
        if Cart.objects.filter(user=request.user, purchased=False).exists() is False:
            tmp_cart = Cart()
            tmp_cart.user = request.user
            tmp_cart.save()
            serializer = CartSerializer(tmp_cart)
        cart = Cart.objects.get(user=request.user, purchased=False)
        serializer = CartSerializer(cart)
        return Response(serializer.data)

        # if User.objects.filter(pk=pk).exists():
        #     if Cart.objects.filter(user_id=pk, purchased=False).exists() == False:
        #         tmp_cart = Cart()
        #         tmp_cart.user = User.objects.get(pk=pk)
        #         tmp_cart.save()
        #     cart = Cart.objects.get(user_id=pk, purchased=False)
        #     serializer = CartSerializer(cart)
        #     return Response(serializer.data)
        # else:
        #     raise Http404

    def post(self, request, format=None):
        serializer = CartProductSerializer(data=request.data)
        if serializer.is_valid():
            if Cart.objects.filter(user=request.user, purchased=False).exists() is False:
                tmp_cart = Cart()
                tmp_cart.user = request.user
                tmp_cart.save()
            if Product.objects.filter(pk=serializer.validated_data['product_id']).exists():
                product = Product.objects.get(
                    pk=serializer.validated_data['product_id'])

                if ProductCart.objects.filter(product_id=serializer.validated_data['product_id'], cart__user=request.user, cart__purchased=False).exists():
                    product_cart = ProductCart.objects.get(product_id=serializer.validated_data['product_id'], cart__user=request.user, cart__purchased=False)
                    if product.units_aviable >= serializer.validated_data['quantity']:
                        cart = Cart.objects.get(user=request.user, purchased=False)
                        product_cart.quantity += serializer.validated_data['quantity']
                        product_cart.save()
                        cart.total_cost += (product.price * product_cart.quantity)
                        cart.save()
                        cart_serializer = CartSerializer(cart)
                        return Response(cart_serializer.data)
                    elif product.units_aviable > 0:
                        cart = Cart.objects.get(user=request.user, purchased=False)
                        product_cart.quantity += product.units_aviable
                        product_cart.save()
                        cart.total_cost += (product.price * product_cart.quantity)
                        cart.save()
                        cart_serializer = CartSerializer(cart)
                        return Response(cart_serializer.data)
                    else:
                        return Response(data={
                            "Message": "Not enough units aviable of product {0} with id {1}".format(product.name,
                                                                                                    product.id)},
                                        status=status.HTTP_401_UNAUTHORIZED)

                else:
                    cart = Cart.objects.get(user=request.user, purchased=False)
                    if product.units_aviable >= serializer.validated_data['quantity']:
                        product_cart = ProductCart()
                        product_cart.product = product
                        product_cart.cart = cart
                        product_cart.quantity = serializer.validated_data['quantity']
                        product_cart.save()
                        tmp_total_cost = 0
                        for product_cart in ProductCart.objects.filter(cart=cart).all():
                            tmp_total_cost += product_cart.quantity * product_cart.product.price
                        cart.total_cost = tmp_total_cost
                        cart.save()
                        cart_serializer = CartSerializer(cart)
                        return Response(cart_serializer.data)
                    elif product.units_aviable > 0:
                        product_cart = ProductCart()
                        product_cart.product = product
                        product_cart.cart = cart
                        product_cart.quantity = product.units_aviable
                        product_cart.save()
                        tmp_total_cost=0
                        for product_cart in ProductCart.objects.filter(cart=cart).all():
                            tmp_total_cost += product_cart.quantity * product_cart.product.price
                        cart.total_cost = tmp_total_cost
                        cart.save()
                        cart_serializer = CartSerializer(cart)
                        return Response(cart_serializer.data)
                    else:
                        return Response(data={
                            "Message": "Not enough units aviable of product {0} with id {1}".format(product.name,
                                                                                                    product.id)},
                                        status=status.HTTP_401_UNAUTHORIZED)

            else:
                return Response(data={"Message": "Product not found"}, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, format=None):
        serializer = CartProductSerializer(data=request.data)
        if serializer.is_valid():
            if Cart.objects.filter(user=request.user, purchased=False).exists() is False:
                tmp_cart = Cart()
                tmp_cart.user = request.user
                tmp_cart.save()
                raise Http404
            if Product.objects.filter(pk=serializer.validated_data['product_id']).exists():
                cart = Cart.objects.get(user=request.user, purchased=False)
                if ProductCart.objects.filter(product_id=serializer.validated_data['product_id'],
                                                       cart_id=cart.id).count()>1:
                    for product_cart in ProductCart.objects.filter(product_id=serializer.validated_data['product_id'],
                                                       cart_id=cart.id).all():
                        cart.total_cost -= (product_cart.product.price *
                                            product_cart.quantity)
                        product_cart.delete()
                        cart.save()

                    response_data = {"Message": "Product deleted from Cart"}
                    return Response(data=response_data, status=status.HTTP_204_NO_CONTENT)
                else:
                    product_cart = ProductCart.objects.get(product_id=serializer.validated_data['product_id'],
                                                           cart_id=cart.id)

                    cart.total_cost -= (product_cart.product.price *
                                        product_cart.quantity)
                    product_cart.delete()
                    cart.save()
                    response_data = {"Message": "Product deleted from Cart"}
                    return Response(data=response_data, status=status.HTTP_204_NO_CONTENT)
            else:
                return Response(data="Product not found", status=status.HTTP_206_PARTIAL_CONTENT)
        else:
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class CartOperations(APIView):
    def get(self, request, format=None):
        carts = Cart.objects.filter(user=request.user)
        serializer = CartSerializer(carts, many=True)
        if serializer.is_valid:
            return Response(serializer.data)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def post(self, request, format=None):

        if Cart.objects.filter(user=request.user, purchased=False).exists():
            if Cart.objects.get(user=request.user, purchased=False).products.count() > 0:

                serializer = PurchasedCartSerializer(data=request.data)
                if serializer.is_valid():
                    cart = Cart.objects.get(user=request.user, purchased=False)

                    if serializer.validated_data['payment_method'] == 'CC':
                        cart.payment = cart.CREDITCARD
                    elif serializer.validated_data['payment_method'] == 'DC':
                        cart.payment = cart.DEBITCARD
                    elif serializer.validated_data['payment_method'] == 'CS':
                        cart.payment = cart.CASH
                    elif serializer.validated_data['payment_method'] == 'PY':
                        cart.payment = cart.PAYPAL
                    else:
                        return Response(data={"Message": "Payment method not provided or invalid"},
                                        status=status.HTTP_304_NOT_MODIFIED)

                    productcarts = cart.products
                    for productcart in productcarts.all():
                        product = productcart.product
                        if product.units_aviable < productcart.quantity:
                            return Response(data={
                                "Message": "Not enough units of product '" + product.name + "' with ID " + product.id + ""},
                                status=status.HTTP_304_NOT_MODIFIED)
                        else:
                            product.units_aviable -= productcart.quantity
                            product.save()

                    cart.purchased = True

                    cart.save()
                    cart_serializer = CartSerializer(cart)
                    if cart_serializer.is_valid:
                        return Response(cart_serializer.data, status=status.HTTP_202_ACCEPTED)
                    else:
                        return Response(cart_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response(data={"Message": "Cart doesnt have products inside"},
                                status=status.HTTP_304_NOT_MODIFIED)
        else:
            tmp_cart = Cart()
            tmp_cart.user = request.user
            tmp_cart.save()
            raise Http404


class StockList(APIView):
    def get(self, request, pk, format=None):
        stocks = Stock.objects.filter(product_id=pk)
        serializer = StockSerializer(stocks, many=True)
        return Response(serializer.data)

    def post(self, request, pk, format=None):
        serializer = StockSerializer(data=request.data)
        if serializer.is_valid():
            if Stock.objects.filter(product_id=pk,
                                    unique_identifier=serializer.validated_data['unique_identifier']).exists():
                return Response(serializer.data, status=status.HTTP_302_FOUND)
            serializer.save()
            product = Product.objects.get(pk=pk)
            product.units_aviable += 1
            product.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
