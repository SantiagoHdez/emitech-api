from api.models import AppUser, Product, Stock, Cart, ProductCart
from api.serializers import AppUserSerializer, ProductSerializer, StockSerializer, CartSerializer, ProductCartSerializer
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