#!/usr/bin/python
# -*- coding: utf8 -*-
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.template import loader
from mainapp.models import *
from django.conf import settings
try:
	from django.utils import simplejson
except:
	import simplejson
from django.template.loader import render_to_string
# Create your views here.


def index(request):
	args = {}
	if request.method == 'POST':
		string = simplejson.loads(request.body)
		if string['method'] == 'loadingindex':
			args['Paragraph'] = Paragraph.objects.all()
			args['content'] = render_to_string('index.html', args)
			return JsonResponse({'string': args['content']})
	template = loader.get_template('main.html')
	args['greatings'] = render_to_string('greatings.html')
	return HttpResponse(template.render(args, request))