# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-09-23 08:01
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('mainapp', '0018_auto_20160923_1036'),
    ]

    operations = [
        migrations.CreateModel(
            name='CustomerOrder',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Name', models.CharField(blank=True, max_length=200, null=True)),
                ('Customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='mainapp.Customer')),
                ('Order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='mainapp.Order')),
            ],
            options={
                'db_table': 'CustomerName',
            },
        ),
        migrations.RemoveField(
            model_name='ordermoderated',
            name='Name',
        ),
    ]
