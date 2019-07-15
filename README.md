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

## UserRole
* role_id
* user_id
* admin_id
* active:boolean

```rails g scaffold UserRole role:references user:references admin:references active:boolean```

## CargappModel
* name
* code
* description
* active

```rails g scaffold CargappModel name code description:text active:boolean```


## Parameter
* name
* code
* description
* user_id
* value
* model_id
* active

```rails g scaffold Parameter name code description:text user:references value cargapp_model:references active:boolean```


## Permission 
* role_id
* model_id
* action
* method
* user_id
* allow
* active

```rails g scaffold Permission role:references cargapp_model:references action method allow:boolean user:references active:boolean```