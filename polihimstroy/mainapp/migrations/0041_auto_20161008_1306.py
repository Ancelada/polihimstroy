# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-10-08 10:06
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0040_auto_20161008_1249'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='KeyWord',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
