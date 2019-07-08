# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create([{ name: 'user', code: 'USER', description: 'Users', active: true },
    { name: 'admin', code: 'ADMIN', description: 'Users adminstrator', active: true },
    { name: 'super', code: 'SUPER', description: 'Users Super adminstrator', active: true },    
    { name: 'driver', code: 'DRIVER', description: 'Users Drivers', active: true }])
