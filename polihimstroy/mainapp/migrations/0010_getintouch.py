# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-08-27 12:23
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0009_paragraph_alphabetorder'),
    ]

    operations = [
        migrations.CreateModel(
            name='GetInTouch',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Name', models.CharField(blank=True, max_length=200, null=True)),
                ('TelNo', models.BigIntegerField(blank=True, null=True)),
                ('Email', models.EmailField(blank=True, max_length=200, null=True)),
                ('Text', models.TextField(blank=True, null=True)),
                ('DateTime', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'GetInTouch',
            },
        ),
    ]
