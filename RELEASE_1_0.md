# Emitech API 1.0

Emitech ha llegado a su version 1.0, la cual trae varios cambios sobre la 'Developer Preview'

## Nuevo sistema de login

Emitech API ahora integra OAuth 2, las instrucciones para utilizar el sistema son las siguientes

1. Se debe registrar el cliente (aplicacion) en $HOST/o/applications

2. Se debe registrar un tipo de cliente, se recomienda para aplicaciones web y movil usar *implicit authentication*

3. La aplicacion proporcionara un *clientid* y un *clientsecretid*, que debera utilizarse para obtener el token de autenticacion

4. Una vez obtenido el token de autorizacion, se agrega dicho token a los HTTP Headers en toda request que lo requiera

Por el momento, solo $HOST/cart requiere forzosamente de OAuth para realizar operaciones, mientras que el resto estan limitadas a Read-Only si no se esta autenticado.

Para mayor informacion puede consultar los links abajo

https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2

https://django-oauth-toolkit.readthedocs.io/en/latest/rest-framework/getting_started.html

## Reemplazo de AppUser por Django auth.user

AppUser es reemplazado por auth.user. Para registrar un usuario, puede utilizar la interfaz en '$HOST/admin' o utilizar el endpoint '$HOST/users' con los siguientes campos en formato JSON o XML

- username (requerido)
- password (requerido)
- email (requerido)
- first_name
- last_name

Los datos de AppUser no son tomados mas en cuenta por la API, por lo que recomendamos crear nuevas cuentas

AppUser sera totalmente eliminado en 1.0.1, una vez se asegure la estabilidad de la API

Nota: Todos los usuarios registrados a traves de $HOST/users son considerados 'Customers' por la API

## Diferencia entre Customer y Staff

Algunas operaciones ahora estan limitadas a usuarios con permiso de 'staff'. Para realizar dichas operaciones, hay que proporcionar cuentas de staff a los trabajadores a traves de '$HOST/admin'

Las operaciones POST, PATCH y DELETE en las siguientes url estan limitadas a usuarios con calidad de 'staff':
- products/
- products/{product_id}/stocks

Registrar usuarios del tipo 'staff' no es posible a traves de '$HOST/users', si requiere una cuenta staff contacte al administrador


## Removido el {user_id} de $HOST/cart y $HOST/cart/ops

Anteriormente el sistema Non-Auth obligaba al cliente a enviar el UserId como parte del request de una operacion. Al limitar las operaciones de $HOST/cart y $HOST/cart/ops a los usuarios con autorizacion, se han removido esa necesidad.

Para seguir utilizando la API con normalidad, reemplaze sus request de formato '$HOST/cart/{user_id}' y '$HOST/cart/{user_id}/ops/' con $HOST/cart y $HOST/cart/ops y sus respectivos HTTP Token Headers



## Añadido fecha de creacion, ultima modificacion y staff member a todos los metodos

Se incluyen campos 'created', 'last_modified', 'created_by' y 'last_modified_by' en
- Product
- Stock
- Address

Se incluyen campos 'created' y 'last_modified' en
- Cart

Debido a su naturaleza volatil, no se incluyen estos campos en ProductCart.

La inclusion de estos campos es meramente informativa y no modifica el comportamiento de la API

## Cambios y verificaciones en diversos metodos

Se han modificado varios metodos para mejorar su funcionamiento y validacion. No debe haber cambios en la forma en la que los mismos operan aparte de los ya descritos
