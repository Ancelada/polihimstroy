# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-24 13:08
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0027_auto_20160924_1537'),
    ]

    operations = [
        migrations.AddField(
            model_name='getintouch',
            name='Quantity',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]