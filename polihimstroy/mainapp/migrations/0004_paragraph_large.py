# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-08-09 09:31
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0003_auto_20160731_1531'),
    ]

    operations = [
        migrations.AddField(
            model_name='paragraph',
            name='Large',
            field=models.NullBooleanField(),
        ),
    ]
