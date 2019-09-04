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


## User
* email
* password
* phone_number
* mobile_verify
* verification_code
* identifiation
* code
* uuid
* provider
* username
* referal_code
* user_referal_code
* pin
* online
* active


```rails g migration AddPhoneToUser phone_number mobile_verify:boolean mobile_code identifiation uuid provider referal_code user_referal_code pin online:boolean active:boolean```


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


## Document 
* document_id
* document_type_id
* file
* status_id
* user_id
* expire_date
* approved
* active


```rails g scaffold Document document_id document_type:references file statu:references user:references expire_date:date approved:boolean active:boolean```

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


```rails g scaffold Profile firt_name last_name avatar phone document_id document_type:references user:references birth_date:date```

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
* owner_document_type_id
* owner_document_id
* user_id
* active


```rails g scaffold Vehicle brand model model_year:integer color plate chassis owner_vehicle vehicle_type:references owner_document_type:references owner_document_id user:references active:boolean```

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
        "vehicle_type_id": 1,
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


```rails g scaffold Challenge name body:text image point:integer user:references active:boolean```

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


```rails g scaffold UserChallenge position:integer point:integer challenge:references user:references active:boolean```

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


```rails g scaffold Coupon name code description is_porcentage:boolean value:integer quantity:integer cargapp_model:references user:references active:boolean```

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
        "cargapp_model_id": 1,
        "active": true
    }
}
```

## UserCoupon
* user_id
* coupon_id
* cargapp_model_id
* applied_item_id
* offert_id
* discount
* active


```rails g scaffold UserCoupon discount cargapp_model:references applied_item_id:integer coupon:references user:references active:boolean```

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
        "applied_item_id": 1,
        "cargapp_model_id": 1,
        "coupon_id": 1,
        "user_id": 1,
        "active": true
    }
}
```


## Prize
* name
* code
* point
* description
* body
* image
* media
* expire_date
* user_id
* active


```rails g scaffold Prize name code point:integer description:text body:text image media expire_date:datetime user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/prizes 'Listar'
2. GET http://api.cargapp.co/api/v1/prizes/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/prizes/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/prizes 'Crear'
5. PUT http://api.cargapp.co/api/v1/prizes/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/prizes/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/prizes/me 'Ver los del usuario'

```
{
    "prize": {
        "name": "la primera carrera",
        "code": "CAA1",
        "point": "CAA1",
        "decription": "CAA1",
        "body": "CAA1",
        "image": "CAA1.png",
        "media": "CAA1.png",
        "expire_date": "18-08-2019 12:12",
        "user_id": 1,
        "active": true
    }
}
```


## UserPrize
* point
* expire_date
* prize_id
* user_id
* active


```rails g scaffold UserPrize point prize:references expire_date:datetime user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_prizes 'Listar'
2. GET http://api.cargapp.co/api/v1/user_prizes/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_prizes/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_prizes 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_prizes/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_prizes/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_prizes/me 'Ver los del usuario'

```
{
    "user_prize": {
        "point": 1,
        "prize_id": 1,
        "expire_date": "18-12-2019 12:12",
        "user_id": 1,
        "active": true
    }
}
```


## ReasonType 
* name
* code
* icon
* description
* active


```rails g scaffold ReasonType name code icon description:text active:boolean```

1. GET http://api.cargapp.co/api/v1/reason_types 'Listar'
2. GET http://api.cargapp.co/api/v1/reason_types/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/reason_types/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/reason_types 'Crear'
5. PUT http://api.cargapp.co/api/v1/reason_types/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/reason_types/:id 'Elimina'

```
{
    "reason_type": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "icon": "image.png",
        "active": true
    }
}
```


## Blocking (After)
* description
* reason_type_id
* statu_id
* user_id
* driver_id
* expire_date
* active


```rails g scaffold Blocking description:text reason:references statu:references expire_date:datetime user:references driver:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_coupons 'Listar'
2. GET http://api.cargapp.co/api/v1/user_coupons/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_coupons/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_coupons 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_coupons/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_coupons/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_coupons/me 'Ver los del usuario'

```
{
    "Prize": {
        "point": 1,
        "prize_id": 1,
        "expire_date": "18-12-2019 12:12",
        "user_id": 1,
        "active": true
    }
}
```

## Activity (After)
* model
* action
* item
* message
* user_id


```rails g scaffold Activity model action item message user:references ```

1. GET http://api.cargapp.co/api/v1/activities 'Listar'
2. GET http://api.cargapp.co/api/v1/activities/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/activities/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/activities 'Crear'
5. PUT http://api.cargapp.co/api/v1/activities/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/activities/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/activities/me 'Ver los del usuario'

```
{
    "activity": {
        "model": "profiles",
        "action": "me",
        "item": "1"
        "message": "ingreso al perfil"
        "user_id": 1
    }
}
```


## PaymentMethod
* name
* uuid
* description
* email
* app_id
* secret_id
* token
* password
* user_id
* active

```rails g scaffold PaymentMethod name uuid description:text email aap_id secret_id token password user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/payment_methods 'Listar'
2. GET http://api.cargapp.co/api/v1/payment_methods/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/payment_methods/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/payment_methods 'Crear'
5. PUT http://api.cargapp.co/api/v1/payment_methods/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/payment_methods/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/payment_methods/me 'Ver los del usuario'

```
{
    "payment_method": {
        "name": "efectivo",
        "uuid": "cargapp2019",
        "description": "metodo de pago en efectivo",
        "email": "hello@cargapp.co",
        "app_id": "cargapp2019",
        "secret_id": "cargapp2019",
        "token": "cargapp2019",
        "password": "cargapp2019",
        "user_id": 1,
        "active": true
    }
}
```


## UserPaymentMethod
* email
* uuid
* token
* card_number
* expiration
* cvv
* observation
* user_id
* payment_method_id
* active

```rails g scaffold UserPaymentMethod email uuid token card_number expiration:date cvv observation:text user:references payment_method:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_payment_methods 'Listar'
2. GET http://api.cargapp.co/api/v1/user_payment_methods/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_payment_methods/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_payment_methods 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_payment_methods/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_payment_methods/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_payment_methods/me 'Ver los del usuario'

```
{
    "user_payment_method": {
        "email": "hello@cargapp.co",
        "uuid": "cargapp2019",
        "token": "cargapp2019",
        "card_number": "123456789",
        "expiration": "02/29",
        "cvv": "029",
        "observation": "metodo de pago en efectivo",
        "payment_method_id": 1,
        "user_id": 1,
        "active": true
    }
}
```



## Report
* name
* origin
* destination
* cause
* sense
* novelty
* geolocation
* image
* start_date
* end_date
* report_type
* user_id
* active

```rails g scaffold Report name origin destination cause sense novelty geolocation image start_date:date end_date:date report_type user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/report_types 'Listar'
2. GET http://api.cargapp.co/api/v1/report_types/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/report_types/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/report_types 'Crear'
5. PUT http://api.cargapp.co/api/v1/report_types/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/report_types/:id 'Elimina'

```
{
    "report_type": {
        "name": "creado",
        "code": "creted",        
        "description": "estado creado para el usro de los estados del modelo servicios o ofertas",
        "icon": "image.png",
        "active": true
    }
}
```


## Service
* name
* origin
* origin_city_id
* origin_address
* origin_longitude
* origin_latitude
* destination
* destination_city_id
* destination_address
* destination_latitude
* destination_longitude
* price
* description
* note
* user_id
* company_id
* user_driver_id
* user_receiver_id
* vehicle_type_id
* vehicle_id
* statu_id
* expiration_date
* contact
* active

```rails g scaffold Service name origin origin_city:references origin_address origin_longitude origin_latitude destination destination_city:references destination_address destination_latitude destination_longitude price:integer description:text note:text user:references company:references user_driver:references user_receiver:references vehicle_type:references vehicle:references statu:references expiration_date:date contact active:boolean```

1. GET http://api.cargapp.co/api/v1/services 'Listar'
2. GET http://api.cargapp.co/api/v1/services/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/services/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/services 'Crear'
5. PUT http://api.cargapp.co/api/v1/services/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/services/:id 'Elimina'

```
{
    "service": {
        "name": "cali, medellin"
        .....
        "active": true
    }
}
```


## ServiceDocument
* name
* document_type
* document_type_id
* document
* service_id
* user_id
* active

```rails g scaffold ServiceDocument name document_type document service:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/services_documents 'Listar'
2. GET http://api.cargapp.co/api/v1/services_documents/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/services_documents/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/services_documents 'Crear'
5. PUT http://api.cargapp.co/api/v1/services_documents/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/services_documents/:id 'Elimina'

```
{
    "service_document": {
        "name": "factura de venta de producto",
        "document_type": "FACTURA",
        "document": "filel.pdf",
        "service_id": 1,
        "user_id": 1,
        "active": true
    }
}
```


## FavoriteRoute
* origin_city_id
* destination_city_id
* user_id
* active

```rails g scaffold FavoriteRoute origin_city:references destination_city:references active:boolean```

1. GET http://api.cargapp.co/api/v1/favorite_routes 'Listar'
2. GET http://api.cargapp.co/api/v1/favorite_routes/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/favorite_routes/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/favorite_routes 'Crear'
5. PUT http://api.cargapp.co/api/v1/favorite_routes/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/favorite_routes/:id 'Elimina'

```
{
    "favorite_route": {
        "origin_city_id": 1,
        "destination_city_id": 2,
        "service_id": 1,
        "user_id": 1,
        "active": true
    }
}
```


## CargappAd
* id
* name
* price
* description
* body
* image
* url
* media
* have_discoun
* is_percentage
* discoun
* user_id
* active

```rails g scaffold CargappAd name price:integer description:text body:text image url media have_discoun:boolean is_percentage:boolean discoun:integer user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/cargapp_ads 'Listar'
2. GET http://api.cargapp.co/api/v1/cargapp_ads/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cargapp_ads/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cargapp_ads 'Crear'
5. PUT http://api.cargapp.co/api/v1/cargapp_ads/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cargapp_ads/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/cargapp_ads/me 'Ver las del usuario'


```
{
    "favorite_route": {
        "origin_city_id": 1,
        "destination_city_id": 2,
        "service_id": 1,
        "user_id": 1,
        "active": true
    }
}
```


## UserLocation
* id
* longitude
* latitude
* city_id
* user_id
* active

```rails g scaffold UserLocation longitude latitude city:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/user_locations 'Listar'
2. GET http://api.cargapp.co/api/v1/user_locations/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/user_locations/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/user_locations 'Crear'
5. PUT http://api.cargapp.co/api/v1/user_locations/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/user_locations/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/user_locations/me 'Ver las del usuario'


```
{
    "user_location": {
        "longitude": 1,
        "latitude": 2,
        "city_id": 1,
        "user_id": 1,
        "active": true
    }
}
```


## ServiceLocation
* id
* longitude
* latitude
* city_id
* user_id
* service_id
* active

```rails g scaffold ServiceLocation longitude latitude city:references user:references service:references active:boolean```

1. GET http://api.cargapp.co/api/v1/service_locations 'Listar'
2. GET http://api.cargapp.co/api/v1/service_locations/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/service_locations/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/service_locations 'Crear'
5. PUT http://api.cargapp.co/api/v1/service_locations/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/service_locations/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/service_locations/me 'Ver las del usuario'


```
{
    "service_location": {
        "longitude": 1,
        "latitude": 2,
        "city_id": 1,
        "user_id": 1,
        "service_id": 1,
        "active": true
    }
}
```


## BankAccount
* id
* account_number
* account_type
* bank
* user_id
* statu_id
* active

```rails g scaffold BankAccount account_number:integer account_type bank user:references statu:references active:boolean```

1. GET http://api.cargapp.co/api/v1/bank_accounts 'Listar'
2. GET http://api.cargapp.co/api/v1/bank_accounts/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/bank_accounts/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/bank_accounts 'Crear'
5. PUT http://api.cargapp.co/api/v1/bank_accounts/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/bank_accounts/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/bank_accounts/me 'Ver las del usuario'


```
{
    "bank_account": {
        "account_number": 1,
        "account_type": 2,
        "bank": 1,
        "user_id": 1,
        "statu_id": 1,
        "active": true
    }
}
```


## RateService
* id
* service_point
* driver_point
* point
* service_id
* user_id
* driver_id
* active

```rails g scaffold RateService service_point:integer driver_point:integer point:integer service:references user:references driver:references active:boolean```

1. GET http://api.cargapp.co/api/v1/rate_services 'Listar'
2. GET http://api.cargapp.co/api/v1/rate_services/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/rate_services/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/rate_services 'Crear'
5. PUT http://api.cargapp.co/api/v1/rate_services/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/rate_services/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/rate_services/me 'Ver las del usuario'


```
{
    "rate_service": {
        "service_point": 1,
        "driver_point": 2,
        "point": 1,
        "service_id": 1,
        "user_id": 1,
        "driver_id": 1,
        "active": true
    }
}
```


## CargappPayment
* id
* uuid
* amount
* transaction_code
* observation
* payment_method_id
* statu_id 
* generator_id
* receiver_id
* user_id
* bank_account_id
* service_id
* company_id
* active

```rails g scaffold CargappPayment uuid amount:integer transaction_code observation:text payment_method:references statu:references generator:references receiver:references bank_account:references service:references company:references user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/cargapp_payments 'Listar'
2. GET http://api.cargapp.co/api/v1/cargapp_payments/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cargapp_payments/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cargapp_payments 'Crear'
5. PUT http://api.cargapp.co/api/v1/cargapp_payments/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cargapp_payments/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/cargapp_payments/me 'Ver las del usuario'


```
{
    "cargapp_payment": {
        "uuid": "asdasd5",
        "amount": 20,
        "transaction_code": "445454",
        "observation": "asdasdasd",
        "payment_method_id": 1,
        "statu_id": 7,
        "generator_id": 1,
        "receiver_id": 2,
        "bank_account_id": 1,
        "service_id": 11,
        "company_id": 2,
        "user_id": 1,
        "active": true
    }
}
```


## Payment
* id
* uuid
* total
* sub_total
* taxes
* transaction_code
* observation
* coupon_id
* coupon_code
* coupon_amount
* user_payment_method_id
* payment_method_id
* statu_id
* user_id
* is_service
* service_id
* active

```rails g scaffold Payment uuid total:integer sub_total:integer taxes:integer  transaction_code observation:text coupon:references coupon_code coupon_amount:integer user_payment_method:references payment_method:references statu:references service:references is_service:boolean user:references active:boolean```

1. GET http://api.cargapp.co/api/v1/cargapp_payments 'Listar'
2. GET http://api.cargapp.co/api/v1/cargapp_payments/active 'Ver activos'
3. GET http://api.cargapp.co/api/v1/cargapp_payments/:id 'Ver detalle'
4. POST http://api.cargapp.co/api/v1/cargapp_payments 'Crear'
5. PUT http://api.cargapp.co/api/v1/cargapp_payments/:id 'Actualiza'
6. DELETE http://api.cargapp.co/api/v1/cargapp_payments/:id 'Elimina'
7. GET http://api.cargapp.co/api/v1/cargapp_payments/me 'Ver las del usuario'


```
{
    "payment": {
        "uuid": "",
        "total": null,
        "sub_total": null,
        "taxes": null,
        "transaction_code": "",
        "observation": "",
        "coupon_id": null,
        "coupon_code": "",
        "coupon_amount": null,
        "user_payment_method_id": 4,
        "payment_method_id": 1,
        "statu_id": 6,
        "service_id": 11,
        "is_service": true,
        "user_id": 1,
        "active": false
    }
}
```



# Login Local for console
irb -r oauth2
app = "ZRylaRGgSD19_gOQVoumEmLueIWlcaBLkw2EkcIKG7Y123456"
secret = "UaF6H-ETL8XlY04V5_U3eUSyehHVHiopXU__bcAcIXI123456"
client = OAuth2::Client.new(app, secret, site: 'http://localhost:3000')
token = client.password.get_token('user@cargapp.co', '123456')
puts token.token


Service
duration
distance