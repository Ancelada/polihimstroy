# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-29 13:23
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0031_auto_20160926_1703'),
    ]

    operations = [
        migrations.AddField(
            model_name='article',
            name='OwnerUrl',
            field=models.URLField(blank=True, null=True),
        ),
    ]