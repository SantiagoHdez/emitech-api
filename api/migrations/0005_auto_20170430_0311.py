# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-04-30 03:11
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_auto_20170430_0257'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='model',
            field=models.CharField(max_length=32),
        ),
        migrations.AlterField(
            model_name='product',
            name='name',
            field=models.CharField(max_length=240),
        ),
    ]
