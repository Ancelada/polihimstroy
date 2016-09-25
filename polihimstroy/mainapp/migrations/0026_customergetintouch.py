# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-24 12:34
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0025_auto_20160924_1452'),
    ]

    operations = [
        migrations.CreateModel(
            name='CustomerGetInTouch',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Name', models.CharField(blank=True, max_length=200, null=True)),
                ('Customer', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='mainapp.Customer')),
                ('GetInTouch', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='mainapp.GetInTouch')),
            ],
            options={
                'db_table': 'CustomerGetInTouch',
            },
        ),
    ]