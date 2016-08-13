#!/usr/bin/python
# -*- coding: utf8 -*-
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.template import loader
from mainapp.models import *
from django.contrib import auth
from django.conf import settings
import json
import requests
import datetime
try:
	from django.utils import simplejson
except:
	import simplejson
from django.template.loader import render_to_string
try:
	from urllib.request import urlopen
	from urllib.parse import urljoin
except ImportError:
	from urllib2 import urlopen	
	from urlparse import urljoin
# Create your views here.

def getbalance():
	params = {}
	params['api_key'] = '42a091e3'
	params['api_secret'] = '76bcfe7a'
	url = \
	 'https://rest.nexmo.com/account/get-balance?api_key=%s&api_secret=%s' %('42a091e3', '76bcfe7a')
	f = urlopen(url)
	json_resp = json.load(f)
	return json_resp['value']

def index(request):
	args = {}
	if request.method == 'POST':
		string = simplejson.loads(request.body)
		# отправить форму заявки
		if string['method'] == 'submit_order':
			name = string['name']
			telephone = string['telephone']
			watsup = string['watsup']
			unit_id = string['unit_id']
			Order.objects.create(Name=name, watsup=watsup, DateTime=datetime.datetime.now(), \
			 Unit_id=unit_id, TelNo=telephone)
			return JsonResponse({'string': 'ok'})
		# форма заявки
		if string['method'] == 'showorderform':
			args['unit_id'] = string['unit_id']
			args['form'] = render_to_string('orderform.html', args)
			return JsonResponse({'string': args['form']})
		# выйти logout
		if string['method'] == 'logout':
			auth.logout(request)
			args['login_panel'] = render_to_string('login_panel.html', args)
			return JsonResponse({'login_panel': args['login_panel']})
		# попытка зайти trylogin
		if string['method'] == 'trylogin':
			username = string['username']
			password = string['password']
			user = auth.authenticate(username=username, password=password)
			if user is not None:
				auth.login(request, user)
				args['username'] = auth.get_user(request)
				args['balance'] = getbalance()
				args['login_panel'] = render_to_string('login_panel.html', args)
				return JsonResponse({'login_panel': args['login_panel'], 'message': 'success'})
			else:
				return JsonResponse({'message': 'aborted'})
		# страница таблица заявок
		if string['method'] == 'orders':
			args['orders'] = Order.objects.all().values('Unit__Name', 'Name', 'watsup', 'DateTime', \
			 'TelNo').order_by('-DateTime')
			args['username'] = auth.get_user(request)
			args['orderstable'] = render_to_string('orderstable.html', args)
			return JsonResponse({'string': args['orderstable']})
		# страница paragraph_unit
		if string['method'] == 'paragraphunit':
			par_id = string['unit']
			args['units'] = Unit.objects.filter(Paragraph_id=par_id).values( \
				'Name', 'Description', 'id')
			args['paragraph_name'] = Paragraph.objects.get(id=par_id).Name
			args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
			return JsonResponse({'string': args['paragraph_unit']})
		# страница index
		if string['method'] == 'loadingindex':
			args['Paragraph'] = Paragraph.objects.all().order_by('No')
			args['content'] = render_to_string('index.html', args)
			return JsonResponse({'string': args['content']})
		# страница login
		if string['method'] == 'login':
			args['content'] = render_to_string('login.html', args)
			return JsonResponse({'string': args['content']})
		# уведомление
		if string['method'] == 'notification':
			args['header'] = string['header']
			args['text'] = string['text']
			if string['type'] == 'alert':
				args['msgtypeclass'] = ' alert'
			elif string['type'] == 'success':
				args['msgtypeclass'] = ' success'
			args['message'] = render_to_string('notification.html', args)
			return JsonResponse({'string': args['message']})
	args['balance'] = getbalance()
	args['username'] = auth.get_user(request)
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	args['greatings'] = render_to_string('greatings.html')
	return HttpResponse(template.render(args, request))