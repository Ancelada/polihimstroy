# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-10-08 10:12
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0041_auto_20161008_1306'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='KeyWord',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='mainapp.KeyWord'),
        ),
    ]
