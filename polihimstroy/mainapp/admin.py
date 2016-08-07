#!/usr/bin/python
# -*- coding: utf8 -*-
from django.contrib import admin
from mainapp.models import *
# Register your models here.
class ParagraphAdmin(admin.ModelAdmin):
	fieldsets = [
		('Наименование', {'fields': ['Name']}),
		('картинка', {'fields': ['Image']}),
	]

class UnitAdmin(admin.ModelAdmin):
	fieldsets = [
		('Наименование', {'fields': ['Name']}),
		('Описание', {'fields': ['Description']}),
		('Параграф', {'fields': ['Paragraph']}),
	]
admin.site.register(Paragraph, ParagraphAdmin)
admin.site.register(Unit, UnitAdmin)