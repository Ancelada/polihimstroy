# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-10-06 06:59
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0033_paragraph_hexcolor'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='paragraph',
            name='HexColor',
        ),
    ]
