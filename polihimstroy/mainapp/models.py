#!/usr/bin/python
# -*- coding: utf8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.

from django.conf import settings
from django.contrib.auth.models import User

class Paragraph(models.Model):
	class Meta():
		db_table = 'Paragraph'
	Name = models.CharField(max_length=200, null=True, blank=True)
	Image = models.ImageField(blank=True, null=True)
	Large = models.NullBooleanField(blank=True, null=True)
	No = models.IntegerField(blank=True, null=True)
	AlignLeft = models.NullBooleanField(blank=True, null=True)
	def __str__(self):
		return self.Name.encode('utf-8')

class Unit(models.Model):
	class Meta():
		db_table = 'Unit'
	Name = models.CharField(max_length=200, null=True, blank=True)
	Description = models.TextField(null=True, blank=True)
	Paragraph = models.ForeignKey(Paragraph, on_delete=models.CASCADE)
	def __str__(self):
		return self.Name.encode('utf-8')

class Order(models.Model):
	class Meta():
		db_table = 'Order'
	Name = models.CharField(max_length=200, null=True, blank=True)
	TelNo = models.BigIntegerField(null=True, blank=True)
	watsup = models.NullBooleanField(blank=True, null=True)
	email = models.EmailField(max_length=200, null=True, blank=True)
	DateTime = models.DateTimeField(blank=True, null=True)
	Unit = models.ForeignKey(Unit, on_delete=models.CASCADE)
	def __str__(self):
		return self.Name.encode('utf-8')