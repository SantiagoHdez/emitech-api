# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-14 20:13
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_product_units_aviable'),
    ]

    operations = [
        migrations.RenameField(
            model_name='stock',
            old_name='unique_idenfitier',
            new_name='unique_identifier',
        ),
    ]
