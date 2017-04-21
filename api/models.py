from django.db import models
import uuid

# Create your models here.


class AppUser(models.Model):
    username = models.CharField(max_length=24)
    password = models.CharField(max_length=18)


class Product(models.Model):
    name = models.CharField(max_length=18)
    model = models.CharField(max_length=24)
    code = models.CharField(max_length=18)
    price = models.DecimalField(max_digits=7, decimal_places=2)
    suggested_price = models.DecimalField(max_digits=7, decimal_places=2, null=True)


class Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.PROTECT, related_name="stocks")
    unique_idenfitier= models.CharField(max_length=18, null=True)
    cost = models.DecimalField(max_digits=7, decimal_places=2)


class Cart(models.Model):
    appuser = models.ForeignKey(AppUser, on_delete=models.PROTECT, related_name="carts")
    total_cost = models.DecimalField(max_digits=8, decimal_places=2)
    purchased = models.BooleanField(default=False)

class ProductCart(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="products")
    quantity = models.IntegerField()
