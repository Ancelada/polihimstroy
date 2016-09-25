#!/usr/bin/python
# -*- coding: utf8 -*-
"""polihimstroy URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Import the include() function: from django.conf.urls import url, include
    3. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import url
from django.contrib import admin
from django.conf import settings
from mainapp import views
from django.http import HttpResponse
from django.views.generic.base import TemplateView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),
    url(r'^paragraph/(?P<paragraph>[0-9]+)$', views.paragraph),
    url(r'^paragraph/(?P<paragraph>[0-9]+)/unit/(?P<unit>[0-9]+)$', views.paragraph_unit),
    url(r'^login/$', views.login),
    url(r'^orders/$', views.orders),
    url(r'^contacts/$', views.contacts),
    url(r'^search/$', views.search),
    url(r'^order_moderated/$', views.order_moderated),
    url(r'^$', views.index, name='index'),
    url(r'^robots\.txt$', \
     TemplateView.as_view(template_name='robots.txt', content_type="text/plain")),
    url(r'^sitemap\.xml/$', views.buildsitemap),
    url(r'^(?P<unit_name>[a-z0-9_\ _+.,-]+)/$', views.oldlinks),
]