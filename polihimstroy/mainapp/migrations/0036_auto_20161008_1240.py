# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-10-08 09:40
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0035_auto_20161008_1236'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='article',
            name='KeyWord',
        ),
        migrations.RemoveField(
            model_name='keyword',
            name='Unit',
        ),
        migrations.DeleteModel(
            name='Article',
        ),
        migrations.DeleteModel(
            name='KeyWord',
        ),
    ]
