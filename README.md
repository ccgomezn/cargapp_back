# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### The code Verify (standardize)

Code style checker

* run command for verify code
`rubocop`

* run command to correct code
`rubocop -a`


##### Temporary in controller models api 
```protect_from_forgery with: :null_session```


# Data Base Models

## Role
* name
* code
* description
* active

```rails g scaffold Role name code:string:index description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/roles 'Listar'
2. GET http://api.cargapp.co/api/v1/roles/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/roles/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/roles 'Crear'
5. PUT http://api.cargapp.co/api/v1/roles/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/roles/:id 'Elimina'

```
{
    "role": {
        "name": "user",
        "code": "USER", 
        "description": "Role para todos los uaurios en general",
        "active": true
    }
}
```


## UserRole
* role_id
* user_id
* admin_id
* active:boolean

```rails g scaffold UserRole role:references user:references admin:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_roles 'Listar'
2. GET http://api.cargapp.co/api/v1/user_roles/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_roles/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_roles 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_roles/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_roles/:id 'Elimina'

```
{
    "user_role": {
        "role_id": 1,
        "user_id": 2,
        "admin_id": 1,
        "active": true
    }
}
```

## CargappModel
* name
* code
* description
* active

```rails g scaffold CargappModel name code description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/cargapp_models 'Listar'
2. GET http://api.cargapp.co/api/v1/cargapp_models/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cargapp_models/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cargapp_models 'Crear'
5. PUT http://api.cargapp.co/api/v1/cargapp_models/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cargapp_models/:id 'Elimina'

```
{
    "cargapp_model": {
        "name": "role",
        "code": "ROLES",
        "value": "roles",
        "description": "Role para todos los uaurios en general",
        "active": true
    }
}
```


## Parameter
* name
* code
* description
* user_id
* value
* model_id
* active

```rails g scaffold Parameter name code description:text user:references value cargapp_model:references active:boolean```

1. GET http://api.cargapp.co/api/v1/parameters 'Listar'
2. GET http://api.cargapp.co/api/v1/parameters/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/parameters/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/parameters 'Crear'
5. PUT http://api.cargapp.co/api/v1/parameters/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/parameters/:id 'Elimina'

```
{
    "parameter": {
        "name": "role",
        "code": "ROLES",
        "description": "Role para todos los uaurios en general",
        "value": "roles, user_roles",
        "user_id": 1,
        "cargapp_model_id": 1,
        "active": true
    }
}
```


## Permission 
* role_id
* model_id
* action
* method
* user_id
* allow
* active

```rails g scaffold Permission role:references cargapp_model:references action method allow:boolean user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/permissions 'Listar'
2. GET http://api.cargapp.co/api/v1/permissions/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/permissions/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/permissions 'Crear'
5. PUT http://api.cargapp.co/api/v1/permissions/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/permissions/:id 'Elimina'

```
{
    "permission": {
        "role_id": 1,
        "user_id": 1,
        "cargapp_model_id": 1,
        "action": "index",
        "method": "GET",
        "allow": true,
        "active": true
    }
}
```


## Statu 
* name
* code
* description
* user_id
* cargapp_model_id
* active

```rails g scaffold Statu name code description:text user:references cargapp_model:references active:boolean```

1. GET http://api.cargapp.co/api/v1/status 'Listar'
2. GET http://api.cargapp.co/api/v1/status/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/status/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/status 'Crear'
5. PUT http://api.cargapp.co/api/v1/status/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/status/:id 'Elimina'

```
{
    "statu": {
        "name": "creado",
        "code": "creted",
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "user_id": 1,
        "cargapp_model_id": 1,
        "active": true
    }
}
```


## Country 
* name
* code
* description
* cioc
* currency_code
* currency_name
* currency_symbol
* language_iso639
* language_name 
* language_native_name
* image
* date_utc
* active


```rails g scaffold Country name code description:text cioc currency_code currency_name currency_symbol language_iso639 language_name language_native_name image date_utc active:boolean```

1. GET http://api.cargapp.co/api/v1/countries 'Listar'
2. GET http://api.cargapp.co/api/v1/countries/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/countries/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/countries 'Crear'
5. PUT http://api.cargapp.co/api/v1/countries/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/countries/:id 'Elimina'
7. PUT http://api.cargapp.co/api/v1/countries/migration 'Actualiza'

```
{
    "country": {
        "name": "creado",
        "code": "creted",
        "cioc": "creee",
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "active": true,
        ..........
    }
}
```

## State 
* name
* code
* description
* country_id
* active


```rails g scaffold State name code description:text country:references active:boolean```

1. GET http://api.cargapp.co/api/v1/states 'Listar'
2. GET http://api.cargapp.co/api/v1/states/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/states/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/states 'Crear'
5. PUT http://api.cargapp.co/api/v1/states/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/states/:id 'Elimina'

```
{
    "state": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "country_id": 1,
        "active": true
    }
}
```


## City 
* name
* code
* description
* state_id
* active


```rails g scaffold City name code description:text state:references active:boolean```

1. GET http://api.cargapp.co/api/v1/cities 'Listar'
2. GET http://api.cargapp.co/api/v1/cities/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cities/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cities 'Crear'
5. PUT http://api.cargapp.co/api/v1/cities/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cities/:id 'Elimina'

```
{
    "city": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "state_id": 1,
        "active": true
    }
}
```

## DocumentType 
* name
* code
* description
* active


```rails g scaffold DocumentType name code description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/document_types 'Listar'
2. GET http://api.cargapp.co/api/v1/document_types/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/document_types/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/document_types 'Crear'
5. PUT http://api.cargapp.co/api/v1/document_types/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/document_types/:id 'Elimina'

```
{
    "document_type": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "active": true
    }
}
```

## VehicleType 
* name
* code
* icon
* description
* active


```rails g scaffold VehicleType name code icon description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/vehicle_types 'Listar'
2. GET http://api.cargapp.co/api/v1/vehicle_types/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/vehicle_types/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/vehicle_types 'Crear'
5. PUT http://api.cargapp.co/api/v1/vehicle_types/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/vehicle_types/:id 'Elimina'

```
{
    "vehicle_type": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "icon": "image.png",
        "active": true
    }
}
```

## LoadType 
* name
* code
* icon
* description
* active


```rails g scaffold LoadType name code icon description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/load_types 'Listar'
2. GET http://api.cargapp.co/api/v1/load_types/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/load_types/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/load_types 'Crear'
5. PUT http://api.cargapp.co/api/v1/load_types/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/load_types/:id 'Elimina'

```
{
    "load_type": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "icon": "image.png",
        "active": true
    }
}
```

##Integration
* name
* description
* provider
* code
* url
* url_provider
* url_production
* url_develop
* email
* username
* password
* phone
* pin
* token
* app_id
* client_id
* api_key
* user:references
* active 


```rails g scaffold CargappIntegration name description:text provider code url url_provider url_production url_develop email username password phone pin token app_id client_id api_key user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/cargapp_integrations 'Listar'
2. GET http://api.cargapp.co/api/v1/cargapp_integrations/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cargapp_integrations/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cargapp_integrations 'Crear'
5. PUT http://api.cargapp.co/api/v1/cargapp_integrations/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cargapp_integrations/:id 'Elimina'

```
{
    "cargapp_integration": {
        "name": "creado",
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "provider": null,
        "code": "creted",
        "url": null,
        "url_provider": null,
        "url_production": null,
        "url_develop": null,
        "email": null,
        "username": null,
        "password": null,
        "phone": null,
        "pin": null,
        "token": null,
        "app_id": null,
        "client_id": null,
        "api_key": null,
        "user_id": 1,
        "active": true
    }
}
```