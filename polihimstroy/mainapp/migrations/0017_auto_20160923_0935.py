# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-23 06:35
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0016_customer'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='Customer',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='mainapp.Customer'),
        ),
        migrations.AddField(
            model_name='order',
            name='Text',
            field=models.TextField(blank=True, null=True),
        ),
    ]
