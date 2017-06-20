# Changelog

2017-06-19

Replacement of DRF TokenAuthorization with Django OAuth Toolkit


2017-06-11

api/views.py
- Replaced most of AppUser implementations with auth.User ones

api/models.py
- Added 'Conekta' model

2017-06-08

api/serializers.py
- Replaced 'appuser' with 'user' in CartSerializer

api/views.py
- ProductCartView
    - Replaced search for user by id with DRF's auth user object

2017-06-07

emitech/settings.py
- Added Django config for TokenAuthorization

api/models.py

- Replaced basic Auth system with django.auth implementation
- Added Address model

api/views.py

- New implementations
    - AppUser is replaced with django.auth.models.User
