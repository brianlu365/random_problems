This project uses:
  Rails 4.2.4
  Ruby 2.2.3

To start run 'bundle' then 'bundle exec rails s'
To run tests run 'bundle exec rspec'

It does not require a database. Calculated results are cached in a YAML file in /lib/cache.yaml.
You can remove cache.yaml if you want. It will be created again next time automatically.

Beside rspec test I used a chrome app call 'RestClient' to test the api.
You will need these in the header:

Content-Type: application/json
Accept: application/json

example url and json:

http://localhost:3000/price
{"zipcode": 94133, "bedroom_count": 2}

http://localhost:3000/booking_rate
{"zipcode": 94133}
since booking rate is independent of bedroom_count, bedroom_count is not needed

http://localhost:3000/earnings
{"start_date": "2015-01-01", "end_date": "2015-01-02","zipcode": 94133, "bedroom_count": 2}
