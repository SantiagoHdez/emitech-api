from django.db import models
import uuid


# Create your models here.


class AppUser(models.Model):
    username = models.CharField(max_length=24)
    password = models.CharField(max_length=18)


class Product(models.Model):
    name = models.CharField(max_length=240)
    model = models.CharField(max_length=32)
    code = models.CharField(max_length=18)
    price = models.DecimalField(max_digits=7, decimal_places=2)
    suggested_price = models.DecimalField(max_digits=7, decimal_places=2, null=True)
    units_aviable = models.IntegerField(default=0)


class Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.PROTECT, related_name="stocks")
    unique_identifier = models.CharField(max_length=18, null=True)
    cost = models.DecimalField(max_digits=7, decimal_places=2)


class Cart(models.Model):
    CREDITCARD = 'CC'
    DEBITCARD = 'DC'
    CASH = 'CS'
    PAYPAL = 'PY'

    PAYMENT_CHOICES = (
        (CREDITCARD, 'CC'),
        (DEBITCARD, 'DC'),
        (CASH, 'CS'),
        (PAYPAL, 'PY')
    )

    appuser = models.ForeignKey(AppUser, on_delete=models.PROTECT, related_name="carts")
    total_cost = models.DecimalField(max_digits=8, decimal_places=2, default=0.0)
    purchased = models.BooleanField(default=False)
    payment = models.CharField(max_length=2, choices=PAYMENT_CHOICES, null=True)


class ProductCart(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="products")
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name="products")
    quantity = models.IntegerField()
