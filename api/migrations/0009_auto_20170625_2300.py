# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-06-25 23:00
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_auto_20170607_1928'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='code',
            field=models.CharField(max_length=18, unique=True),
        ),
    ]
