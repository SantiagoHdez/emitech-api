"""emitech URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from api import views as api_views

urlpatterns = [
    url(r'^admin/', admin.site.urls),


    url(r'^users/$', api_views.AppUserList.as_view()),
    url(r'^users/(?P<pk>[0-9]{1,})/$', api_views.AppUserDetail.as_view()),


    url(r'^products/$', api_views.ProductList.as_view()),
    url(r'^products/(?P<pk>[0-9]{1,})/$', api_views.ProductDetail.as_view()),

    url(r'^cart/(?P<pk>[0-9]{1,})/add-product/$', api_views.ProductCartView.as_view())
]
