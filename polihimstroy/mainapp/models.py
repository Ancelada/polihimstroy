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
	AlphabetOrder = models.NullBooleanField(blank=True, null=True)
	TransportFlag = models.NullBooleanField(blank=True, null=True)
	def __str__(self):
		return self.Name.encode('utf-8')

class Unit(models.Model):
	class Meta():
		db_table = 'Unit'
	Name = models.CharField(max_length=200, null=True, blank=True)
	Description = models.TextField(null=True, blank=True)
	Paragraph = models.ForeignKey(Paragraph, on_delete=models.CASCADE)
	Eng = models.CharField(max_length=200, null=True, blank=True)
	def __str__(self):
		return self.Name.encode('utf-8')
# заказчик
class Customer(models.Model):
	class Meta():
		db_table = 'Customer'
	Type = models.CharField(max_length=200, blank=True, null=True)
	def __str__(self):
		return self.Type.encode('utf-8')

# заявка на химческое сырье и др услуги
class Order(models.Model):
	class Meta():
		db_table = 'Order'
	Name = models.CharField(max_length=200, null=True, blank=True)
	TelNo = models.BigIntegerField(null=True, blank=True)
	watsup = models.NullBooleanField(blank=True, null=True)
	email = models.EmailField(max_length=200, null=True, blank=True)
	DateTime = models.DateTimeField(blank=True, null=True)
	Unit = models.ForeignKey(Unit, on_delete=models.CASCADE)
	Text = models.TextField(null=True, blank=True)
	Customer = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
	Quantity = models.IntegerField(null=True, blank=True)
	DeliveryDate = models.DateTimeField(null=True, blank=True)
	def __str__(self):
		return self.Name.encode('utf-8')

class CustomerOrder(models.Model):
	class Meta():
		db_table = 'CustomerOrder'
	Name = models.CharField(max_length=200, blank=True, null=True)
	Customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
	Order = models.ForeignKey(Order, on_delete=models.CASCADE)

# заявка на транспортировку
class TransportOrder(models.Model):
	class Meta():
		db_table = 'TransportOrder'
	Name = models.CharField(max_length=200, null=True, blank=True)
	TelNo = models.BigIntegerField(null=True, blank=True)
	From = models.CharField(max_length=200, null=True, blank=True)
	To = models.CharField(max_length=200, null=True, blank=True)
	Volume = models.IntegerField(null=True, blank=True)
	watsup = models.NullBooleanField(blank=True, null=True)
	email = models.EmailField(max_length=200, null=True, blank=True)
	DateTime = models.DateTimeField(blank=True, null=True)
	Unit = models.ForeignKey(Unit, on_delete=models.CASCADE)
	Text = models.TextField(null=True, blank=True)
	Customer = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
	DeliveryDate = models.DateTimeField(null=True, blank=True)
	def __str__(self):
		return self.Name.encode('utf-8')

class CustomerTransportOrder(models.Model):
	class Meta():
		db_table = 'CustomerTransportOrder'
	Name = models.CharField(max_length=200, blank=True, null=True)
	Customer = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
	TransportOrder = models.ForeignKey(TransportOrder, null=True, on_delete=models.CASCADE)

# пожелания и предложения
class GetInTouch(models.Model):
	class Meta():
		db_table = 'GetInTouch'
	Name = models.CharField(max_length=200, null=True, blank=True)
	TelNo = models.BigIntegerField(null=True, blank=True)
	Email = models.EmailField(max_length=200, null=True, blank=True)
	Text = models.TextField(null=True, blank=True)
	Quantity = models.IntegerField(null=True, blank=True)
	DateTime = models.DateTimeField(blank=True, null=True)
	Unit = models.ForeignKey(Unit, null=True, on_delete=models.CASCADE)
	Customer = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
	DeliveryDate = models.DateTimeField(null=True, blank=True)
	def __str__(self):
		return self.Name.encode('utf-8')

class CustomerGetInTouch(models.Model):
	class Meta():
		db_table = 'CustomerGetInTouch'
	Name = models.CharField(max_length=200, null=True, blank=True)
	Customer = models.ForeignKey(Customer, null=True, on_delete=models.CASCADE)
	GetInTouch = models.ForeignKey(GetInTouch, null=True, on_delete=models.CASCADE)

#######################
# модерированные заказы
#######################
class OrderModerated(models.Model):
	class Meta():
		db_table = 'OrderModerated'
	Text = models.TextField(null=True, blank=True)
	From = models.CharField(max_length=200, null=True, blank=True)
	To = models.CharField(max_length=200, null=True, blank=True)
	DateTime = models.DateTimeField(blank=True, null=True)
	def __str__(self):
		return self.Name.encode('utf-8')

# связи заявок на химию, траспорт, предложений с модерированными заказами
class OrderModeratedOrder(models.Model):
	class Meta():
		db_table = 'OrderModeratedOrder'
	OrderModerated = models.ForeignKey(OrderModerated, on_delete=models.CASCADE)
	Order = models.ForeignKey(Order, on_delete=models.CASCADE)

class OrderModeratedTransportOrder(models.Model):
	class Meta():
		db_table = 'OrderModeratedTransportOrder'
	OrderModerated = models.ForeignKey(OrderModerated, on_delete=models.CASCADE)
	TransportOrder = models.ForeignKey(TransportOrder, on_delete=models.CASCADE)

class OrderModeratedGetInTouch(models.Model):
	class Meta():
		db_table = 'OrderModeratedGetInTouch'
	OrderModerated = models.ForeignKey(OrderModerated, on_delete=models.CASCADE)
	GetInTouch = models.ForeignKey(GetInTouch, on_delete=models.CASCADE)

# внутренние ссылки между модерированными заявками и услугами
class OrderModeratedUnit(models.Model):
	class Meta():
		db_table = 'OrderModeratedUnit'
	OrderModerated = models.ForeignKey(OrderModerated, on_delete=models.CASCADE)
	Unit = models.ForeignKey(Unit, on_delete=models.CASCADE)

class OrderModeratedParagraph(models.Model):
	class Meta():
		db_table = 'OrderModeratedParagraph'
	OrderModerated = models.ForeignKey(OrderModerated, on_delete=models.CASCADE)
	Paragraph = models.ForeignKey(Paragraph, on_delete=models.CASCADE)