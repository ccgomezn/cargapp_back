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
7. GET http://api.cargapp.co/api/v1/cargapp_integrations/me 'Ver los del usuario'

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


## Company 
* name
* description
* company_type
* load_type_id
* sector
* legal_representative
* address
* phone
* user_id
* constitution_date
* active


```rails g scaffold Company name description:text company_type load_type:references sector legal_representative address phone user:references constitution_date:date active:boolean```

1. GET http://api.cargapp.co/api/v1/companies 'Listar'
2. GET http://api.cargapp.co/api/v1/companies/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/companies/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/companies 'Crear'
5. PUT http://api.cargapp.co/api/v1/companies/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/companies/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/companies/me 'Ver los del usuario'

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

## Ticket 
* title
* body
* image
* media
* status_id
* user_id
* active


```rails g scaffold Ticket title body:text image media statu:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/tickets 'Listar'
2. GET http://api.cargapp.co/api/v1/tickets/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/tickets/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/tickets 'Crear'
5. PUT http://api.cargapp.co/api/v1/tickets/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/tickets/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/tickets/me 'Ver los del usuario'

```
{
    "ticket": {
        "title": "creado",
        "body": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "image": "image.png",
        "media": "archivo.pdf",
        "statu_id": 1,
        "user_id": 1,
        "active": true
    }
}
```

# AQUI

## Document 
* document_id
* document_type_id
* file
* status_id
* user_id
* expire_date
* approved
* active


```rails g scaffold Document document_id document_type:references file statu:rferences user:references expire_date:date approved:boolean active:boolean```

1. GET http://api.cargapp.co/api/v1/documents 'Listar'
2. GET http://api.cargapp.co/api/v1/documents/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/documents/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/documents 'Crear'
5. PUT http://api.cargapp.co/api/v1/documents/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/documents/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/documents/me 'Ver los del usuario'

```
{
    "document": {
        "document_id": "1086726268",
        "document": "1086726268",
        "number": "1086726268",
        "document_type_id": 1,
        "file": "archivo.pdf",
        "expire_date": "10-09-2019"
        "statu_id": 1,
        "user_id": 1,
        "approved": true,
        "active": true
    }
}
```


## Profile 
* firt_name
* last_name
* avatar
* phone
* document_id
* document_type_id
* birth_date
* user_id


```rails g scaffold Profile firt_name last_name avatar phone:number document_id document_type:references user:references birth_date:date```

1. GET http://api.cargapp.co/api/v1/profiles 'Listar'
2. GET http://api.cargapp.co/api/v1/profiles/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/profiles/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/profiles 'Crear'
5. PUT http://api.cargapp.co/api/v1/profiles/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/profiles/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/profiles/me 'Ver los del usuario'

```
{
    "profile": {
        "firt_name": "segundo",
        "last_name": "espana",
        "avatar": "foto.png",
        "phone": "573156257773",
        "document_id": "1086726268",
        "document_type_id": 1,
        "birth_date": "10-09-2019",
        "user_id": 1
    }
}
```


## Vehicle 
* brand
* model
* model_year
* color
* plate 
* chassis
* owner_vehicle
* vehicle_type_id
* user_id
* active


```rails g scaffold Vehicle brand model model_year:integer color plate chassis owner_vehicle vehicle_type:references owner_document_type:refrences user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/vehicles 'Listar'
2. GET http://api.cargapp.co/api/v1/vehicles/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/vehicles/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/vehicles 'Crear'
5. PUT http://api.cargapp.co/api/v1/vehicles/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/vehicles/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/vehicles/me 'Ver los del usuario'

```
{
    "vehicle": {
        "brand": "mazda",
        "model": "2",
        "model_year": 2019,
        "color": "white",
        "plate": "528-SRC"
        "chassis": "segundo1w35djjd",
        "owner_vehicle": "segundo españa bastidas",
        "owner_document_id": "10922222",
        "vehicle_type": 1,
        "owner_document_type_id": 1, 
        "user_id": 1,
        "active": true
    }
}
```


## Challenge 
* name
* body
* image
* point 
* user_id
* active


```rails g scaffold Challenge name body:text image point:number user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/challenges 'Listar'
2. GET http://api.cargapp.co/api/v1/challenges/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/challenges/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/challenges 'Crear'
5. PUT http://api.cargapp.co/api/v1/challenges/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/challenges/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/challenges/me 'Ver los del usuario'

```
{
    "challenge": {
        "name": "los 3 primeros viajes",
        "body": "quien ejecte los primeros 3 viajes ganara 10 puntos",
        "image": "image.png",
        "point": 12,
        "user_id": 1,
        "active": true
    }
}
```


## UserChallenge
* position
* point 
* challenge_id
* user_id
* active


```rails g scaffold UserChallenge position:number point:number challenge:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_challenges 'Listar'
2. GET http://api.cargapp.co/api/v1/user_challenges/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_challenges/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_challenges 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_challenges/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_challenges/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_challenges/me 'Ver los del usuario'

```
{
    "user_challenge": {
        "position": "los 3 primeros viajes",
        "point": 12,
        "user_id": 1,
        "challenge_id": 1,
        "active": true
    }
}
```


## Coupon
* name
* code
* description
* cargapp_model_id
* is_porcentage
* value
* quantity
* user_id
* active


```rails g scaffold Coupon name code description is_porcentage:boolean value:number quantity:number * cargapp_model:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/coupons 'Listar'
2. GET http://api.cargapp.co/api/v1/coupons/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/coupons/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/coupons 'Crear'
5. PUT http://api.cargapp.co/api/v1/coupons/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/coupons/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/coupons/me 'Ver los del usuario'

```
{
    "coupon": {
        "name": "Todos 10",
        "code": "TODO10", 
        "description": "10% de decuento para todos",
        "is_porcentage": true,
        "value": 10,
        "quantity": 100,    
        "user_id": 1,
        "active": true
    }
}
```

## UserCoupon
* user_id
* coupon_id
* cargapp_model_id
* offert_id
* discount
* active


```rails g scaffold UserCoupon discount offert:references cargarpp_model:references coupon:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_coupons 'Listar'
2. GET http://api.cargapp.co/api/v1/user_coupons/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_coupons/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_coupons 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_coupons/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_coupons/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_coupons/me 'Ver los del usuario'

```
{
    "user_coupon": {
        "discount": 10,
        "offert_id": 2,
        "cargapp_model_id": 1,
        "cupon_id": 1,
        "user_id": 1,
        "active": true
    }
}
```