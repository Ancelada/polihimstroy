# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-08-27 14:45
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0012_transportorder'),
    ]

    operations = [
        migrations.AddField(
            model_name='transportorder',
            name='Volume',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
