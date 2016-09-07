#!/usr/bin/python
# -*- coding: utf8 -*-
from django.shortcuts import render, redirect
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
from transliterate import translit, get_available_language_codes
from django.template.loader import render_to_string
try:
	from urllib.request import urlopen
	from urllib.parse import urljoin
except ImportError:
	import urllib
	import urllib2
	from urllib2 import urlopen	
	from urlparse import urljoin
import smtplib
from email.MIMEText import MIMEText
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

#отправить sms
def sendsms(sms_receivers, text):
	for i in sms_receivers:
		params = {
			'api_key': '42a091e3',
			'api_secret': '76bcfe7a',
			'to': i,
			'from': 'polihimstroy',
			'text': text
		}
		url = 'https://rest.nexmo.com/sms/json?' + urllib.urlencode(params)
		try:
			request = urllib2.Request(url)
			request.add_header('Accept', 'application/json')
			response = urllib2.urlopen(request)
			return True
		except:
			return False
def sendemail(email_receivers, text):
	try:
		for i in email_receivers:
			subj = 'Полихимстрой. Заявка.'
			subj = translit(subj.decode('utf-8'), 'ru', reversed=True)
			me = 'robot@polihimstroy.ru'
			you = i
			text = text
			subj = subj
			server = 'smtp.fullspace.ru'
			port = 25
			user_name = 'robot@polihimstroy.ru'
			user_passwd = 'tzkpolihimstroy115648'
			msg = MIMEText(text)
			msg['Subject'] = subj
			msg['From'] = me
			msg['To'] = you
			s = smtplib.SMTP(server)
			s.ehlo()
			s.starttls()
			s.ehlo()
			s.login(user_name, user_passwd)
			s.sendmail(me, you, msg.as_string())
			s.quit()
		return True
	except:
		return False

def index(request):
	args = {}
	if request.method == 'POST':
		string = simplejson.loads(request.body)
		# показать карту
		if string['method'] == 'schema':
			schema = render_to_string('schema.html')
			return JsonResponse({'string': schema})
		# отправить форму пожелания и предлжения
		if string['method'] == 'getintouch':
			name = string['name']
			telephone = string['telephone']
			email = string['email']
			text = string['text']
			# записываем в БД
			GetInTouch.objects.create(Name=name, TelNo=telephone, Email=email, Text=text, \
			 DateTime=datetime.datetime.now())
			name = translit(name, 'ru', reversed=True)
			text = translit(text, 'ru', reversed=True)
			getintouch_text = \
			 'Polihimstroy. Pozhelanie i predlozhenie ot %s. Telephone:8%s. Email:%s. Text:%s' \
			%(name, telephone, email, text)
			# отправляем смс
			sms_receivers = ['79276793788', '79178683718']
			smsresp = sendsms(sms_receivers, getintouch_text)
			# отправляем email
			email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			emailresp = sendemail(email_receivers, getintouch_text)
			if smsresp and emailresp:
				return JsonResponse({'string': 'ok'})
			else:
				return JsonResponse({'string': 'notok'})
		# отправить форму заявки на транспорт
		if string['method'] == 'submit_transport_order':
			name = string['name']
			telephone = string['telephone']
			target_from = string['from']
			target_to = string['to']
			volume = string['volume']
			watsup = string['watsup']
			unit_id = string['unit_id']
			# записываем в БД
			TransportOrder.objects.create(Name=name, TelNo=telephone, From=target_from, \
			 To=target_to, watsup=watsup, DateTime=datetime.datetime.now(), Unit_id=unit_id, \
			 Volume=volume)
			if watsup == 0:
				contact = 'telephone:8%s' % telephone
			elif watsup == 1:
				contact = 'whatsapp:8%s' % telephone
			unit_name = translit(Unit.objects.get(id=unit_id).Name, 'ru', reversed=True)
			name = translit(name, 'ru', reversed=True)
			target_from = translit(target_from, 'ru', reversed=True)
			target_to = translit(target_to, 'ru', reversed=True)
			volume = translit(volume, 'ru', reversed=True)
			text =  """Polihimstroy. Zayavka na perevozku gruza %s. 
			Mesto otpravki: %s. Mesto naznachenia: %s. Objem gruza %s. Zakazchik: %s. %s
			 """ %(unit_name, target_from, target_to, volume, name, contact)
			# отправить смс
			sms_receivers = ['79276793788', '79178683718']
			smsresp = sendsms(sms_receivers, text)
			# отправить email
			email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			emailresp = sendemail(email_receivers, text)
			if smsresp and emailresp:
				return JsonResponse({'string': 'ok'})
			else:
				return JsonResponse({'string': 'notok'})
		# отправить форму заявки
		if string['method'] == 'submit_order':
			name = string['name']
			telephone = string['telephone']
			watsup = string['watsup']
			unit_id = string['unit_id']
			# записываем в БД
			Order.objects.create(Name=name, watsup=watsup, DateTime=datetime.datetime.now(), \
			 Unit_id=unit_id, TelNo=telephone)
			if watsup == 0:
				contact = 'telephone:8%s' % telephone
			elif watsup == 1:
				contact = 'whatsapp:8%s' % telephone
			unit_name = translit(Unit.objects.get(id=unit_id).Name, 'ru', reversed=True)
			name = translit(name, 'ru', reversed=True)
			text = 'Polihimstroy. Zayavka na %s ot %s. %s' %(unit_name, name, contact)
			# отправить смс
			sms_receivers = ['79276793788', '79178683718']
			smsresp = sendsms(sms_receivers, text)
			# отправить email
			email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			emailresp = sendemail(email_receivers, text)
			if smsresp and emailresp:
				return JsonResponse({'string': 'ok'})
			else:
				return JsonResponse({'string': 'notok'})
		# форма заявки на транспорт
		if string['method'] == 'showtransportform':
			args['unit_id'] = string['unit_id']
			args['form'] = render_to_string('transportform.html', args)
			return JsonResponse({'string': args['form']})
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
				args['username_name'] = auth.get_user(request).username
				args['username'] = auth.get_user(request).id
				args['balance'] = getbalance()
				args['login_panel'] = render_to_string('login_panel.html', args)
				return JsonResponse({'login_panel': args['login_panel'], 'message': 'success'})
			else:
				return JsonResponse({'message': 'aborted'})
		# страница контакты
		if string['method'] == 'contacts':
			args['username_name'] = auth.get_user(request).username
			args['username'] = auth.get_user(request).id
			args['contact'] = render_to_string('contacts.html', args)
			return JsonResponse({'string': args['contact']})
		# страница таблица заявок, пожелания и предложения
		if string['method'] == 'orders':
			args['orders'] = Order.objects.all().values('Unit__Name', 'Name', 'watsup', 'DateTime', \
			 'TelNo').order_by('-DateTime')
			args['transport_orders'] = TransportOrder.objects.all().values('Unit__Name', 'Name', \
				'From', 'To', 'Volume', 'watsup', 'DateTime', 'TelNo').order_by('-DateTime')
			args['getintouch'] = GetInTouch.objects.all().values('Name', 'TelNo', 'Email', 'Text', \
				'DateTime').order_by('-DateTime')
			args['username_name'] = auth.get_user(request).username
			args['username'] = auth.get_user(request).id
			args['orderstable'] = render_to_string('orderstable.html', args)
			return JsonResponse({'string': args['orderstable']})
		# страница paragraph unit unit
		if string['method'] == 'paragraphunitunit':
			args['par_id'] = string['par_id']
			args['unit_id'] = string['unit_id']
			args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
		'Name', 'Description', 'id').order_by('Name')
			a = Paragraph.objects.get(id=args['par_id'])
			args['paragraph_name'] = a.Name
			args['transport_flag'] = a.TransportFlag
			args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
			return JsonResponse({'string': args['paragraph_unit']})
		# страница paragraph_unit
		if string['method'] == 'paragraphunit':
			args['par_id'] = string['unit']
			a = Paragraph.objects.get(id=args['par_id'])
			alphabet = a.AlphabetOrder
			args['transport_flag'] = a.TransportFlag
			if alphabet:
				args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
					'Name', 'Description', 'id').order_by('Name')
			else:
				args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
					'Name', 'Description', 'id').order_by('Name')
			args['paragraph_name'] = Paragraph.objects.get(id=args['par_id']).Name
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
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	# args['greatings'] = render_to_string('greatings.html')
	return HttpResponse(template.render(args, request))

# страница paragraph
def paragraph(request, paragraph=1):
	args = {}
	args['par_id'] = paragraph
	alphabet = Paragraph.objects.get(id=args['par_id']).AlphabetOrder
	if alphabet:
		args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
			'Name', 'Description', 'id').order_by('Name')
	else:
		args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
			'Name', 'Description', 'id')
	a = Paragraph.objects.get(id=args['par_id'])
	args['paragraph_name'] = a.Name
	args['transport_flag'] = a.TransportFlag
	print args['transport_flag']
	args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница unit
def paragraph_unit(request, paragraph=1, unit=1):
	args = {}
	args['par_id'] = paragraph
	args['unit_id'] = int(unit)
	args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
		'Name', 'Description', 'id').order_by('Name')
	a = Paragraph.objects.get(id=args['par_id'])
	args['paragraph_name'] = a.Name
	args['transport_flag'] = a.TransportFlag
	args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница login
def login(request):
	args = {}
	args['paragraph_unit'] = render_to_string('login.html', args)
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница orders
def orders(request):
	args = {}
	args['orders'] = Order.objects.all().values('Unit__Name', 'Name', 'watsup', 'DateTime', \
		 'TelNo').order_by('-DateTime')
	args['paragraph_unit'] = render_to_string('orderstable.html', args)
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница контакты
def contacts(request):
	args = {}
	args['paragraph_unit'] = render_to_string('contacts.html', args)
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))
# старые ссылки
def oldlinks(request, unit_name=0):
	a = Unit.objects.get(Eng=unit_name)
	return redirect('/paragraph/%s/unit/%s' % (a.Paragraph_id, a.id))