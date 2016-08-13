# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-08-13 07:05
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0007_order'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='TelNo',
            field=models.BigIntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='order',
            name='email',
            field=models.EmailField(blank=True, max_length=200, null=True),
        ),
    ]
