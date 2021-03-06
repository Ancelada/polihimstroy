#!/usr/bin/python
# -*- coding: utf8 -*-
from django.contrib import admin
from mainapp.models import *
# Register your models here.
class KeyWordAdmin(admin.ModelAdmin):
	fieldsets = [
		('Словосочетание', {'fields': ['Name']}),
		('Услуга или сырье', {'fields': ['Unit']})
	]

class ArticleAdmin(admin.ModelAdmin):
	fieldsets = [
		('Текст', {'fields': ['Text']}),
		('Словосочетание', {'fields': ['KeyWord']}),
		('Источник', {'fields': ['OwnerUrl']})
	]

class ParagraphAdmin(admin.ModelAdmin):
	fieldsets = [
		('Наименование', {'fields': ['Name']}),
		('картинка', {'fields': ['Image']}),
		('Признак большая картинка', {'fields': ['Large']}),
		('Порядковый номер', {'fields': ['No']}),
		('Ориентация по левому краю', {'fields': ['AlignLeft']}),
		('В алфавитном порядке', {'fields': ['AlphabetOrder']}),
		('Флаг перевозки грузов да/нет', {'fields': ['TransportFlag']})
	]

class UnitAdmin(admin.ModelAdmin):
	fieldsets = [
		('Наименование', {'fields': ['Name']}),
		('Описание', {'fields': ['Description']}),
		('Параграф', {'fields': ['Paragraph']}),
		('Транслит английского', {'fields': ['Eng']}),
		('Закупка кубовыми ёмкостями, бочками', {'fields': ['CanBuyInCubes']}),
		('Доставка в регионы', {'fields': ['DeliveryInRegion']}),
		('Услуги по разгрузке/погрузке', {'fields': ['CanLoadUnload']})
	]

class CustomerAdmin(admin.ModelAdmin):
	fieldsets = [
		('Тип заказчика', {'fields': ['Type']})
	]
class GetInTouchAdmin(admin.ModelAdmin):
	fieldsets = [
		('Имя', {'fields': ['Name']}),
		('Номер телефона', {'fields': ['TelNo']}),
		('э.почта', {'fields': ['Email']}),
		('Текст', {'fields': ['Text']}),
		('Количество (кг)', {'fields': ['Quantity']}),
		('Дата', {'fields': ['DateTime']}),
		('Сырье', {'fields': ['Unit']}),
		('Заказчик', {'fields': ['Customer']}),
		('Дата доставки', {'fields': ['DeliveryDate']})
	]
admin.site.register(Article, ArticleAdmin)
admin.site.register(KeyWord, KeyWordAdmin)
admin.site.register(GetInTouch, GetInTouchAdmin)
admin.site.register(Customer, CustomerAdmin)
admin.site.register(Paragraph, ParagraphAdmin)
admin.site.register(Unit, UnitAdmin)