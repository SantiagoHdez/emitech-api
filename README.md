# Emitech API #

API para la tienda de Emitech

## Acciones ##

* Registrar usuarios e inventario
* Realizar compras

## Configuracion ##

Emitech API es un proyecto Django REST Framework estandar

### Requisitos ###

* Python 3 (no funciona con Python 2)
* Una base de datos relacional (se recomienda PostgreSQL, funciona con MySQL/MariaDB tambien)
* Para mayor comodidad, un cliente REST como Postman o una herramienta como Apiary

### Configuración ###

1. Instalar Python 3 de acuerdo a su sistema operativo
2. Realizar un 
```
#!bash

pip install requirements.txt
```
3. Configurar su base de datos de acuerdo a *emitech/settings.py*

## Contribuciones ##
AWS Access Key:
AKIAJJFJCGBOYC7LIKNQ
AWS Secret Key:
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

### Requisitos ###

* NO USAR PYTHON 2
    * Esta aplicación se escribe con Python 3, y se despliega en entornos Python 3

* NO INCLUIR CAMBIOS A **DATABASES** EN *emitech/settings.py*
    * Emitech API funciona sobre una db PostgreSQL en producción, no cambie esa parte de los settings

* NO USAR DJANGO TEMPLATES
    * El objetivo de esta aplicación es meramente la de ser una API, por lo que no debe incluir