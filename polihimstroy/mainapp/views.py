#!/usr/bin/python
# -*- coding: utf8 -*-
from django.shortcuts import render, redirect, render_to_response
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
from django.views.generic.base import TemplateView
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
		try:
			url = 'https://rest.nexmo.com/sms/json?' + urllib.urlencode(params)
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
		# удалить модерированную заявку на сырье, транспорт, пожелание и предложение
		if string['method'] == 'delete_moderated':
			ordermoderated_id = string['ordermoderated_id']
			if string['type'] == 'order':
				order_id = OrderModeratedOrder.objects.get(OrderModerated_id=ordermoderated_id).Order_id
				CustomerOrder.objects.filter(Order_id=order_id).delete()
				OrderModerated.objects.filter(id=ordermoderated_id).delete()
			if string['type'] == 'transport_order':
				transport_order_id = OrderModeratedTransportOrder.objects.get( \
					OrderModerated_id=ordermoderated_id).TransportOrder_id
				CustomerTransportOrder.objects.filter(TransportOrder_id=transport_order_id).delete()
				OrderModerated.objects.filter(id=ordermoderated_id).delete()
			if string['type'] == 'get_in_touch':
				get_in_touch_id = OrderModeratedGetInTouch.objects.get( \
					OrderModerated_id=ordermoderated_id).GetInTouch_id
				CustomerGetInTouch.objects.filter(GetInTouch_id=get_in_touch_id).delete()
				OrderModerated.objects.filter(id=ordermoderated_id).delete()
			# обновляем страничку Модерирование заказов
			getmainvalues(args, request)
			order_moderated_content(args)
			args['order_moderated'] = render_to_string('order_moderated.html', args)
			return JsonResponse({'string': 'ok', 'page': args['order_moderated']})	
		# удалить заявку на сырье, транспорт, пожелание и предложение
		if string['method'] == 'delete':
			order_id = string['order_id']
			if string['type'] == 'order':
				Order.objects.filter(id=order_id).delete()
			elif string['type'] == 'transport_order':
				TransportOrder.objects.filter(id=order_id).delete()
			elif string['type'] == 'get_in_touch':
				GetInTouch.objects.filter(id=order_id).delete()
			# обновляем страничку Модерирование заказов
			getmainvalues(args, request)
			order_moderated_content(args)
			args['order_moderated'] = render_to_string('order_moderated.html', args)
			return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
		# подтвердить модерирование
		if string['method'] == 'submit_moderate':
			if string['type'] == 'order_moderate':
				try:
					order_id = string['order_id']
					customer_id = string['customer_id']
					customer_name = string['customer_name']
					quantity = string['quantity']
					text = string['text']
					delivery_date = datetime.datetime.strptime(string['delivery_date'], '%m-%d-%Y').date()
					# заполняем количество заказываемого товара, дату доставки
					Order.objects.filter(id=order_id).update(Quantity=quantity, \
					 DeliveryDate=delivery_date, Customer_id=customer_id)
					# создаем объект заказчик - заказ (Таблица)
					CustomerOrder.objects.create(Name=customer_name, \
					 Customer_id=customer_id, Order_id=order_id)
					# создаем объект модерированные заказы
					a = OrderModerated.objects.create(Text=text, DateTime=datetime.datetime.now())
					# coздаем объект модерированный заказ - заказ
					OrderModeratedOrder.objects.create(OrderModerated_id=a.id, Order_id=order_id)
					# обновляем страничку Модерирование заказов
					getmainvalues(args, request)
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
				except:
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'error', 'page': args['order_moderated']})
			elif string['type'] == 'transport_order_moderate':
				try:
					order_id = string['order_id']
					customer_id = string['customer_id']
					customer_name = string['customer_name']
					tr_from = string['from']
					tr_to = string['to']
					text = string['text']
					volume = string['volume']
					delivery_date = datetime.datetime.strptime(string['delivery_date'], '%m-%d-%Y' \
						).date()
					# заполяняем дату доставки и объем груза
					TransportOrder.objects.filter(id=order_id).update(DeliveryDate=delivery_date, \
					 Volume=volume, Customer_id=customer_id)
					# создаем объект заказчик - заказ (таблица)
					CustomerTransportOrder.objects.create(Name=customer_name, \
						Customer_id=customer_id, TransportOrder_id=order_id)
					# созаем объект модерированные заказы
					a = OrderModerated.objects.create(From=tr_from, To=tr_to, Text=text, \
					 DateTime=datetime.datetime.now())
					# создаем объект модерированный заказ на транспорт - заказ на транспорт
					OrderModeratedTransportOrder.objects.create(OrderModerated_id=a.id, \
					 TransportOrder_id=order_id)
					# обновляем страничку Модерирование заказов
					getmainvalues(args, request)
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
				except:
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
			elif string['type'] == 'getintouch_moderate':
				try:
					getintouch_id = string['getintouch_id']
					customer_id = string['customer_id']
					customer_name = string['customer_name']
					text = string['text']
					unit = string['unit']
					quantity = string['quantity']
					delivery_date = datetime.datetime.strptime(string['delivery_date'], '%m-%d-%Y' \
						).date()
					# заполняем дату доставки, количество
					GetInTouch.objects.filter(id=getintouch_id).update(DeliveryDate=delivery_date, \
						Quantity=quantity, Customer_id=customer_id, Unit_id=unit)
					# создаем объект заказчик - пожелание и предложение (таблица)
					CustomerGetInTouch.objects.create(Name=customer_name, \
						Customer_id=customer_id, GetInTouch_id=getintouch_id)
					# создаем объект модерированные заказы
					a = OrderModerated.objects.create(Text=text, DateTime=datetime.datetime.now())
					# создаем объект можерированное пожелание и предложение - пожелание и предложение
					OrderModeratedGetInTouch.objects.create(OrderModerated_id=a.id, \
						GetInTouch_id=getintouch_id)
					# обновляем страничку Модерирование заказов
					getmainvalues(args, request)
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
				except:
					order_moderated_content(args)
					args['order_moderated'] = render_to_string('order_moderated.html', args)
					return JsonResponse({'string': 'ok', 'page': args['order_moderated']})
		# форма модерирования заявок и предложений
		if string['method'] == 'moderate_form':
			order_type = string['order_type']
			order_id = string['id']
			args['order_id'] = order_id
			args['customer'] = Customer.objects.all()
			if order_type == 'order':
				a = Order.objects.filter(id=order_id)[0]
				args['Name'] = a.Name
				args['Text'] = a.Text
				form = render_to_string('moderate/order_moderate_form.html', args)
				return JsonResponse({'string': form})
			elif order_type == 'transport_order':
				a = TransportOrder.objects.filter(id=order_id)[0]
				args['Name'] = a.Name
				args['From'] = a.From
				args['To'] = a.To
				args['Volume'] = a.Volume
				args['Text'] = a.Text
				form = render_to_string('moderate/transport_order_moderate_form.html', args)
				return JsonResponse({'string': form})
			elif order_type == 'get_in_touch':
				a = GetInTouch.objects.filter(id=order_id)[0]
				args['Name'] = a.Name
				args['Text'] = a.Text
				args['units'] = Unit.objects.all()
				form = render_to_string('moderate/get_in_touch_moderate_form.html', args)
				return JsonResponse({'string': form})
		# поиск по ключевому слову
		if string['method'] == 'searchkeyup':
			word = string['word']
			args['units'] = Unit.objects.filter(Name__icontains=word \
				).values('id', 'Paragraph__TransportFlag', \
				'Name', 'Description', 'Paragraph_id', 'Paragraph__Name')
			args['searchresult'] = render_to_string('searchresult.html', args)
			return JsonResponse({'string': args['searchresult']})
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
			text = translit(text, 'ru', reversed=True).replace(u'\xab', '').replace(u'\xbb', '')
			getintouch_text = \
			 'Polihimstroy. Pozhelanie i predlozhenie ot %s. Telephone:8%s. Email:%s. Text:%s' \
			%(name, telephone, email, text)
			# отправляем смс
			# sms_receivers = ['79276793788', '79178683718']
			# smsresp = sendsms(sms_receivers, getintouch_text)
			smsresp = 1
			# отправляем email
			# email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			# emailresp = sendemail(email_receivers, getintouch_text)
			emailresp = 1
			getmainvalues(args, request)
			contacts_content(args)
			if smsresp and emailresp:
				return JsonResponse({'string': 'ok', 'paragraph_unit': args['paragraph_unit']})
			else:
				return JsonResponse({'string': 'notok', 'paragraph_unit': args['paragraph_unit']})
		# отправить форму заявки на транспорт
		if string['method'] == 'submit_transport_order':
			name = string['name']
			telephone = string['telephone']
			target_from = string['from']
			target_to = string['to']
			volume = string['volume']
			text = string['text']
			email = string['email']
			watsup = string['watsup']
			unit_id = string['unit_id']
			# записываем в БД
			TransportOrder.objects.create(Name=name, TelNo=telephone, From=target_from, \
			 To=target_to, watsup=watsup, DateTime=datetime.datetime.now(), Unit_id=unit_id, \
			 Volume=volume, Text=text, email=email)
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
			# sms_receivers = ['79276793788', '79178683718']
			# smsresp = sendsms(sms_receivers, text)
			smsresp = 1
			# отправить email
			# email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			# emailresp = sendemail(email_receivers, text)
			emailresp = 1
			if smsresp and emailresp:
				return JsonResponse({'string': 'ok'})
			else:
				return JsonResponse({'string': 'notok'})
		# отправить форму заявки
		if string['method'] == 'submit_order':
			name = string['name']
			telephone = string['telephone']
			text = string['text']
			email = string['email']
			watsup = string['watsup']
			unit_id = string['unit_id']
			# записываем в БД
			Order.objects.create(Name=name, Text=text, watsup=watsup, DateTime=datetime.datetime.now(), \
			 Unit_id=unit_id, TelNo=telephone, email=email)
			if watsup == 0:
				contact = 'telephone:8%s' % telephone
			elif watsup == 1:
				contact = 'whatsapp:8%s' % telephone
			unit_name = translit(Unit.objects.get(id=unit_id).Name, 'ru', reversed=True)
			name = translit(name, 'ru', reversed=True)
			text = 'Polihimstroy. Zayavka na %s ot %s. %s' %(unit_name, name, contact)
			# отправить смс
			# sms_receivers = ['79276793788', '79178683718']
			# smsresp = sendsms(sms_receivers, text)
			smsresp = 1
			# отправить email
			# email_receivers = ['anceladamusic@gmail.com', '2502505@mail.ru']
			# emailresp = sendemail(email_receivers, text)
			emailresp = 1
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
				getmainvalues(args, request)
				return JsonResponse({'login_panel': args['login_panel'], 'message': 'success'})
			else:
				return JsonResponse({'message': 'aborted'})
		# страница модерирование заказов
		if string['method'] == 'order_moderated':
			getmainvalues(args, request)
			order_moderated_content(args)
			args['order_moderated'] = render_to_string('order_moderated.html', args)
			return JsonResponse({'string': args['order_moderated']})
		# страница контакты
		if string['method'] == 'contacts':
			args['username_name'] = auth.get_user(request).username
			args['username'] = auth.get_user(request).id
			contacts_content(args)
			args['paragraph_unit'] = render_to_string('contacts.html', args)
			return JsonResponse({'string': args['paragraph_unit']})
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
			args['unit_keywords'] = KeyWord.objects.all()
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
			args['unit_keywords'] = KeyWord.objects.all()
			args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
			return JsonResponse({'string': args['paragraph_unit']})
		# страница index
		if string['method'] == 'loadingindex':
			args['Paragraph'] = Paragraph.objects.all().order_by('No')
			args['content'] = render_to_string('index.html', args)
			return JsonResponse({'string': args['content']})
		# страница поиска search
		if string['method'] == 'search':
			args['content'] = render_to_string('search.html', args)
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
	getmainvalues(args, request)
	args['Paragraph'] = Paragraph.objects.all().order_by('No')
	# мета теги
	# args['description'] = 'Химическое сырье, перевозка грузов, собственная спецтехника.'
	args['description'] = render_to_string('meta_index_keywords.html', args)
	args['keywords'] = render_to_string('meta_index_keywords.html', args)
	args['meta'] = render_to_string('meta.html', args)
	# блок структурированных данных ld+json
	args['index'] = render_to_string('google/google_structure_index.html', args)
	args['structure'] = render_to_string('google/google_structure.html', args)
	template = loader.get_template('main.html')
	# навигация google
	args['index'] = render_to_string('google/site_navigation_index.html', args)
	args['site_navigation_element'] = render_to_string('google/site_navigation.html', args)
	# args['greatings'] = render_to_string('greatings.html')
	return HttpResponse(template.render(args, request))

# страница paragraph
def paragraph(request, paragraph=1):
	args = {}
	getmainvalues(args, request)
	args['par_id'] = paragraph
	alphabet = Paragraph.objects.get(id=args['par_id']).AlphabetOrder
	if alphabet:
		args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
			'Name', 'Description', 'id', 'Paragraph_id', 'Paragraph__Name').order_by('Name')
	else:
		args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
			'Name', 'Description', 'id', 'Paragraph_id', 'Paragraph__Name')
	a = Paragraph.objects.get(id=args['par_id'])
	args['paragraph_name'] = a.Name
	args['transport_flag'] = a.TransportFlag
	args['unit_keywords'] = KeyWord.objects.all()
	args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
	# meta тэг
	# args['description'] = args['paragraph_name']
	args['description'] = render_to_string('meta_paragraph_keywords.html', args)
	args['keywords'] = render_to_string('meta_paragraph_keywords.html', args)
	args['meta'] = render_to_string('meta.html', args)
	# блок структурированных данных ld+json
	args['paragraph'] = render_to_string('google/google_structure_paragraph.html', args)
	args['structure'] = render_to_string('google/google_structure.html', args)
	# блок навигация google
	args['navigation_paragraph'] = render_to_string('google/site_navigation_paragraph.html', args)
	args['site_navigation_element'] = render_to_string('google/site_navigation.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница unit
def paragraph_unit(request, paragraph=1, unit=1):
	args = {}
	getmainvalues(args, request)
	args['par_id'] = paragraph
	args['unit_id'] = int(unit)
	args['units'] = Unit.objects.filter(Paragraph_id=args['par_id']).values( \
		'Name', 'Description', 'id', 'Paragraph__Name').order_by('Name')
	for i in args['units']:
		if i['id'] == args['unit_id']:
			args['unit_name'] = i['Name']
			args['unit_description'] = i['Description']
	a = Paragraph.objects.get(id=args['par_id'])
	args['paragraph_name'] = a.Name
	args['transport_flag'] = a.TransportFlag
	args['unit_keywords'] = KeyWord.objects.all()
	args['paragraph_unit'] = render_to_string('paragraph_unit.html', args)
	# meta тэг
	args['description'] = args['unit_description']
	args['keywords'] = render_to_string('meta_paragraph_unit_keywords.html', args)
	args['meta'] = render_to_string('meta.html', args)
	# блок структурированных данных ld+json
	args['paragraph_google_unit'] = render_to_string( \
		'google/google_structure_paragraph_unit.html', args)
	args['structure'] = render_to_string('google/google_structure.html', args)
	# блок навигации google
	args['navigation_paragraph_unit'] = render_to_string( \
		'google/site_navigation_paragraph_unit.html', args)
	args['site_navigation_element'] = render_to_string('google/site_navigation.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница login
def login(request):
	args = {}
	getmainvalues(args, request)
	args['paragraph_unit'] = render_to_string('login.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница orders
def orders(request):
	args = {}
	getmainvalues(args, request)
	args['orders'] = Order.objects.all().values('Unit__Name', 'Name', 'watsup', 'DateTime', \
		 'TelNo').order_by('-DateTime')
	args['paragraph_unit'] = render_to_string('orderstable.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

def contacts_content(args):
	args['all_orders'] = []
	# заявки на сырье, транспорт, пожелания и предложения
	m_orders = []
	orders = OrderModeratedOrder.objects.all().values('Order_id')
	for o in orders:
		m_orders.append(o['Order_id'])
	args['orders'] = Order.objects.all().exclude(id__in = m_orders \
		).values('Name', 'watsup', 'DateTime', 'Unit__Name', \
				'TelNo', 'email', 'id', 'Text', 'Unit__id', 'Unit__Paragraph_id')
	for i in args['orders']:
		args['all_orders'].append({'date': i['DateTime'], 'name': i['Name'], \
			'unit': i['Unit__Name'], 'text': i['Text'], 'customer_type': False, 'customer_name': False, \
			'quantity': False, 'delivery_date': False, 'status': 'в рассмотрении', \
			 'unit_id': i['Unit__id'], 'paragraph_id': i['Unit__Paragraph_id'], \
			  'status_schema': 'OrderProcessing'})
	m_tr_orders = []
	tr_orders = OrderModeratedTransportOrder.objects.all().values('TransportOrder_id')
	for tr in tr_orders:
		m_tr_orders.append(tr['TransportOrder_id'])
	args['transport_orders'] = TransportOrder.objects.all().exclude( \
		id__in = m_tr_orders).values('Name', 'watsup', 'DateTime', \
		'Unit__Name', 'TelNo', 'email', 'From', 'To', 'id', 'Text', 'Volume', 'Unit__id', \
		'Unit__Paragraph_id')
	for i in args['transport_orders']:
		args['all_orders'].append({'date': i['DateTime'], 'name': i['Name'], \
			'unit': i['Unit__Name'], 'text': i['Text'], 'customer_type': False, 'customer_name':False, \
			'quantity': False, 'delivery_date': False, 'status': 'в рассмотрении', \
			 'unit_id': i['Unit__id'], 'paragraph_id': i['Unit__Paragraph_id'], \
			 'status_schema': 'OrderProcessing'})
	git = []
	git_orders = OrderModeratedGetInTouch.objects.all().values('GetInTouch_id')
	for gt in git_orders:
		git.append(gt['GetInTouch_id'])
	args['get_in_touch'] = GetInTouch.objects.all().exclude( \
		id__in = git).values('Name', 'DateTime', 'Text', 'TelNo', \
	 'Email', 'id')
	for i in args['get_in_touch']:
		args['all_orders'].append({'date': i['DateTime'], 'name': i['Name'], 'unit': False, \
			'text': i['Text'], 'customer_type': False, 'customer_name': False, \
			'quantity': False, 'delivery_date': False, 'status': 'в рассмотрении', \
			'status_schema': 'OrderProcessing'})
	# модерированные заявки на сырье, транспорт, пожелание и предложение
	args['order_moderated_order'] = OrderModeratedOrder.objects.all().values('OrderModerated__DateTime', \
		'Order__customerorder__Customer__Type', 'Order__customerorder__Name', \
		'Order__Unit__Name', 'Order__Quantity', 'OrderModerated__Text', 'Order__DeliveryDate', \
		'OrderModerated__id', 'Order__Unit__id', 'Order__Unit__Paragraph_id')
	for i in args['order_moderated_order']:
		args['all_orders'].append({'date': i['OrderModerated__DateTime'], \
		 'name': i['Order__customerorder__Name'], 'unit': i['Order__Unit__Name'], \
		 'text': i['OrderModerated__Text'], 'customer_type': i['Order__customerorder__Customer__Type'], \
		 'customer_name': i['Order__customerorder__Name'], 'quantity': i['Order__Quantity'], \
		 'delivery_date': i['Order__DeliveryDate'], 'status': 'рассмотрена', \
		  'unit_id': i['Order__Unit__id'], 'paragraph_id': i['Order__Unit__Paragraph_id'], \
		  'status_schema': 'OrderDelivered'})
	args['order_moderated_transport_order'] = OrderModeratedTransportOrder.objects.all().values( \
		'OrderModerated__DateTime', 'TransportOrder__customertransportorder__Customer__Type', \
		'TransportOrder__customertransportorder__Name', 'TransportOrder__Unit__Name', \
		'TransportOrder__Volume', 'OrderModerated__From', 'OrderModerated__To', 'OrderModerated__Text', \
		'TransportOrder__DeliveryDate', 'OrderModerated__id', 'TransportOrder__Unit__id', \
		'TransportOrder__Unit__Paragraph_id')
	for i in args['order_moderated_transport_order']:
		args['all_orders'].append({'date': i['OrderModerated__DateTime'], \
		 'name': i['TransportOrder__customertransportorder__Name'], \
		  'unit': i['TransportOrder__Unit__Name'], 'text': i['OrderModerated__Text'], \
		  'customer_type': i['TransportOrder__customertransportorder__Customer__Type'], \
		  'customer_name': i['TransportOrder__customertransportorder__Name'], \
		  'quantity': i['TransportOrder__Volume'], 'delivery_date': i['TransportOrder__DeliveryDate'], \
		  'status': 'рассмотрена', 'unit_id': i['TransportOrder__Unit__id'], \
		  'paragraph_id': i['TransportOrder__Unit__Paragraph_id'], 'status_schema': 'OrderDelivered'})
	args['order_moderated_getintouch'] = OrderModeratedGetInTouch.objects.all().values( \
		'OrderModerated__DateTime', 'GetInTouch__customergetintouch__Customer__Type', \
 		'GetInTouch__customergetintouch__Name', 'GetInTouch__Unit__Name', 'GetInTouch__Quantity', \
  		'OrderModerated__Text', 'GetInTouch__DeliveryDate', 'OrderModerated__id', \
  		'GetInTouch__Unit__id', 'GetInTouch__Unit__Paragraph_id')
	for i in args['order_moderated_getintouch']:
		args['all_orders'].append({'date': i['OrderModerated__DateTime'], \
		 'name': i['GetInTouch__customergetintouch__Name'], 'unit': i['GetInTouch__Unit__Name'], \
		 'text': i['OrderModerated__Text'], \
		 'customer_type': i['GetInTouch__customergetintouch__Customer__Type'], \
		 'customer_name': i['GetInTouch__customergetintouch__Name'], \
		 'quantity': i['GetInTouch__Quantity'], 'delivery_date': i['GetInTouch__DeliveryDate'], \
		 'status': 'рассмотрена', 'unit_id': i['GetInTouch__Unit__id'], \
		 'paragraph_id': i['GetInTouch__Unit__Paragraph_id'], 'status_schema': 'OrderDelivered'})
	args['all_orders'] = sorted(args['all_orders'], key=lambda k: k['date'], reverse=True)
	args['all_orders_delivered'] = []
	for i in args['all_orders']:
		if i['status_schema'] == 'OrderDelivered':
			args['all_orders_delivered'].append(i)
	# google разметка заказы
	args['order'] = render_to_string('google/google_order.html', args)
	args['paragraph_unit'] = render_to_string('contacts.html', args)

# страница контакты
def contacts(request):
	args = {}
	getmainvalues(args, request)
	contacts_content(args)
	# мета описания
	args['description'] = 'Контакты'
	args['keywords'] = '420095,Респ.Татарстан,г. Казань,ул. Восстания,100'
	args['meta'] = render_to_string('meta.html', args)
	# блок структурированных данных ld+json
	args['contacts'] = render_to_string( \
		'google/google_structure_contacts.html')
	args['structure'] = render_to_string('google/google_structure.html', args)
	# навигация google
	args['contacts'] = render_to_string('google/site_navigation_contacts.html', args)
	args['site_navigation_element'] = render_to_string('google/site_navigation.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# страница поиска
def search(request):
	args = {}
	getmainvalues(args, request)
	# мета описания
	args['description'] = 'Поиск по ключевому слову'
	args['keywords'] = 'По ключевому слову, нечеткий поиск'
	args['meta'] = render_to_string('meta.html', args)
	args['paragraph_unit'] = render_to_string('search.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))


def getmainvalues(args, request):
	args['balance'] = getbalance()
	args['username_name'] = auth.get_user(request).username
	args['username'] = auth.get_user(request).id
	args['login_panel'] = render_to_string('login_panel.html', args)


# функция наполнения модерированные заказы
def order_moderated_content(args):
	m_orders = []
	orders = OrderModeratedOrder.objects.all().values('Order_id')
	for o in orders:
		m_orders.append(o['Order_id'])
	args['orders'] = Order.objects.all().exclude(id__in = m_orders \
		).values('Name', 'watsup', 'DateTime', 'Unit__Name', \
				'TelNo', 'email', 'id', 'Text')
	m_tr_orders = []
	tr_orders = OrderModeratedTransportOrder.objects.all().values('TransportOrder_id')
	for tr in tr_orders:
		m_tr_orders.append(tr['TransportOrder_id'])
	args['transport_orders'] = TransportOrder.objects.all().exclude( \
		id__in = m_tr_orders).values('Name', 'watsup', 'DateTime', \
		'Unit__Name', 'TelNo', 'email', 'From', 'To', 'id', 'Text', 'Volume')
	git = []
	git_orders = OrderModeratedGetInTouch.objects.all().values('GetInTouch_id')
	for gt in git_orders:
		git.append(gt['GetInTouch_id'])
	args['get_in_touch'] = GetInTouch.objects.all().exclude( \
		id__in = git).values('Name', 'DateTime', 'Text', 'TelNo', \
	 'Email', 'id')
	args['order_moderated_order'] = OrderModeratedOrder.objects.all().values('OrderModerated__DateTime', \
		'Order__customerorder__Customer__Type', 'Order__customerorder__Name', \
		'Order__Unit__Name', 'Order__Quantity', 'OrderModerated__Text', 'Order__DeliveryDate', \
		'OrderModerated__id')
	args['order_moderated_transport_order'] = OrderModeratedTransportOrder.objects.all().values( \
		'OrderModerated__DateTime', 'TransportOrder__customertransportorder__Customer__Type', \
		'TransportOrder__customertransportorder__Name', 'TransportOrder__Unit__Name', \
		'TransportOrder__Volume', 'OrderModerated__From', 'OrderModerated__To', 'OrderModerated__Text', \
		'TransportOrder__DeliveryDate', 'OrderModerated__id')
	args['order_moderated_getintouch'] = OrderModeratedGetInTouch.objects.all().values( \
		'OrderModerated__DateTime', 'GetInTouch__customergetintouch__Customer__Type', \
 		'GetInTouch__customergetintouch__Name', 'GetInTouch__Unit__Name', 'GetInTouch__Quantity', \
  		'OrderModerated__Text', 'GetInTouch__DeliveryDate', 'OrderModerated__id')

# форма создать править модерированные заказы
def order_moderated(request):
	args = {}
	getmainvalues(args, request)
	order_moderated_content(args)
	args['order_moderated'] = render_to_string('login_panel.html', args)
	template = loader.get_template('main.html')
	return HttpResponse(template.render(args, request))

# старые ссылки
def oldlinks(request, unit_name=0):
	try:
		a = Unit.objects.get(Eng=unit_name)
	except:
		if unit_name == 'address':
			return redirect('/contacts')
		elif unit_name == 'o_kompanii':
			return redirect('/contacts')
		elif unit_name == 'lakokrasochnaya-produkciya':
			return redirect('/paragraph/3')
		elif unit_name == 'prays-list-po-himicheskomu-syryu':
			return redirect('/')
		elif unit_name == 'bochki-kubovye-yomkosti':
			return redirect('/paragraph/2')
		elif unit_name == 'glicerin-distilirovannyy-marok-d-98':
			return redirect('/paragraph/1/unit/20')
		elif unit_name == 'himicheskoe-syre':
			return redirect('/paragraph/1')
		elif unit_name == 'nashi-partnery':
			return redirect('/contacts')
		elif unit_name == 'mail':
			return redirect('/contacts')
		elif unit_name == 'butilcellozol':
			return redirect('/paragraph/1/unit/1')
		elif unit_name == 'teplonositel-antifriz-tosol':
			return redirect('/paragraph/5')
		elif unit_name == 'diproksamin-157':
			return redirect('/paragraph/1/unit/2')
		elif unit_name == 'tetranatrievaya-sol':
			return redirect('/paragraph/1/unit/24')
		elif unit_name == 'uslugi':
			return redirect('/paragraph/6')
		elif unit_name == 'kokamidopropilaminoksid':
			return redirect('/paragraph/1/unit/26')
		elif unit_name == 'alkilbenzolsulfokislota-absk':
			return redirect('/paragraph/1/unit/31')
		elif unit_name == 'othody-polietilena-pvd':
			return redirect('/paragraph/8/unit/58')
		elif unit_name == 'arenda-spectehniki':
			return redirect('/paragraph/7')
		elif unit_name == 'perevozki':
			return redirect('/paragraph/6')
		elif unit_name == 'stati/article_post/vtoraya':
			return redirect('/')
	return redirect('/paragraph/%s/unit/%s' % (a.Paragraph_id, a.id))

def buildsitemap(request):
	args = {}
	# главная страница
	args['index'] = render_to_string('sitemap_index.html')
	# страница поиска
	args['search'] = render_to_string('sitemap_search.html')
	# страница контакты
	args['contacts'] = render_to_string('sitemap_contacts.html')
	# страница paragraph
	a = Paragraph.objects.all().values('id')
	args['paragraph'] = render_to_string('sitemap_paragraph.html', {'a': a})
	# страница paragraph unit
	a = Unit.objects.all().values('Paragraph_id', 'id')
	args['paragraph_unit'] = render_to_string('sitemap_paragraph_unit.html', {'a': a})	
	template = loader.get_template('sitemap.xml')
	return HttpResponse(template.render(args, request), content_type="text/plain")