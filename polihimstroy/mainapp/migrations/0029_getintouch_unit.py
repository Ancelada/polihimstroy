# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-24 13:32
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0028_getintouch_quantity'),
    ]

    operations = [
        migrations.AddField(
            model_name='getintouch',
            name='Unit',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='mainapp.Unit'),
        ),
    ]