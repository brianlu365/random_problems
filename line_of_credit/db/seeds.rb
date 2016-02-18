# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Transaction.create( day_number: 1, change_amount: 500, transaction_type: 'withdraw')
Transaction.create( day_number: 15, change_amount: -200, transaction_type: 'payment')
Transaction.create( day_number: 25, change_amount: 100, transaction_type: 'withdraw')