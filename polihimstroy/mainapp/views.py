#!/usr/bin/python
# -*- coding: utf8 -*-
from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
# Create your views here.


def index(request):
	args = {}
	template = loader.get_template('index.html')
	return HttpResponse(template.render(args, request))