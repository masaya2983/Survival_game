# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
    { name: '屋外' },
    { name: 'インドア' },
    { name: '森林'},
    { name: '砂漠'},
    { name: '市街戦	'},
    { name: '塹壕'},
    { name: '平地'},
    { name: '複合'} 
    ])