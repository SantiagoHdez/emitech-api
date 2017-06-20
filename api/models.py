from django.db import models
from django.contrib.auth.models import User
import uuid
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver

# Create your models here.


class AppUser(models.Model):
    username = models.CharField(max_length=24)
    password = models.CharField(max_length=18)


class Address(models.Model):
    user = models.OneToOneField(User, on_delete=models.PROTECT)
    street = models.TextField()
    neighborhood = models.CharField(max_length=180)
    city = models.CharField(max_length=180)
    state = models.CharField(max_length=60)
    postal_code = models.CharField(max_length=5)


class Product(models.Model):
    name = models.CharField(max_length=240)
    model = models.CharField(max_length=32)
    code = models.CharField(max_length=18)
    price = models.DecimalField(max_digits=7, decimal_places=2)
    suggested_price = models.DecimalField(
        max_digits=7, decimal_places=2, null=True)
    units_aviable = models.IntegerField(default=0)


class Stock(models.Model):
    product = models.ForeignKey(
        Product, on_delete=models.PROTECT, related_name="stocks")
    unique_identifier = models.CharField(max_length=18, null=True)
    cost = models.DecimalField(max_digits=7, decimal_places=2)


class Cart(models.Model):
    CONEKTA = 'CK'
    CREDITCARD = 'CC'
    DEBITCARD = 'DC'
    CASH = 'CS'
    PAYPAL = 'PY'

    PAYMENT_CHOICES = (
        (CONEKTA, 'CK'),
        (CREDITCARD, 'CC'),
        (DEBITCARD, 'DC'),
        (CASH, 'CS'),
        (PAYPAL, 'PY')
    )

    user = models.ForeignKey(
        User, on_delete=models.PROTECT, related_name="carts")
    total_cost = models.DecimalField(
        max_digits=8, decimal_places=2, default=0.0)
    purchased = models.BooleanField(default=False)
    payment = models.CharField(
        max_length=2, choices=PAYMENT_CHOICES, null=True)


class ProductCart(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    product = models.ForeignKey(
        Product, on_delete=models.CASCADE, related_name="products")
    cart = models.ForeignKey(
        Cart, on_delete=models.CASCADE, related_name="products")
    quantity = models.IntegerField()
