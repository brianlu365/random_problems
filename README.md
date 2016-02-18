# random_problems

## youtube_data_checker

This command line tool takes two files and a third optional concern as arguments.

**Example Usage:**
```
yt_data_checker [file1.csv] [file2.csv] [concern]
* concern is optional
```

**Options:**
 - files: Required. The two sets of data are provided below
 - concerns: Optional `subscriber_count` or `channel_ownership`

**Output:**
- Output a list of account emails with a discrepancy, line delimited
- If a concern is provided, only output discrepancies related to that data
- If no concern is provided, output all the unique discrepancies

## property_rental_api

example url and json:

http://localhost:3000/price
{"zipcode": 94133, "bedroom_count": 2}

http://localhost:3000/booking_rate
{"zipcode": 94133}
since booking rate is independent of bedroom_count, bedroom_count is not needed

http://localhost:3000/earnings
{"start_date": "2015-01-01", "end_date": "2015-01-02","zipcode": 94133, "bedroom_count": 2}

## factors_and_caching

Input: Given an array of integers

Output: In whatever representation you wish, output each integer in the array and all the other integers in the array that are
factors of the first integer.  

Example:

  Given an array of [10, 5, 2, 20], the output would be:

{10: [5, 2], 5: [], 2: [], 20: [10,5,2]}

## line_of_credit

A line of credit rails app. 
It should work like this:

  - Have a built in APR and credit limit
  - Be able to draw ( take out money ) and make payments.
  - Keep track of principal balance and interest on the line of credit
  - APR Calculation based on the outstanding principal balance over real number of days.
  - Interest is not compounded, so it is only charged on outstanding principal.
  - Keep track of transactions such as payments and draws on the line and when
    they occured.
  - 30 day payment periods.  Basically what this means is that interest will not be
    charged until the closing of a 30 day payment period.  However, when it is charged,
    it should still be based on the principal balance over actual number of days outstanding
    during the period, not just ending principal balance.
    
## string_to_JSON

Convert this string string = "{key:[[value1, value2],[value3, value4]], 5:10:00AM]}" 
to this hash: h = {"key" => [["value1", "value2"],["value3", "value4"]], 5=>"10:00AM"} 
then convert h to JSON. Please note that the brackets are unbalanced on purpose.

## metaprogram_hash_value

Write a class Sample whose initialize method takes an arbitrary hash, 
e.g. h = {"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 'here'} 
and represent each key in the hash as an attribute of an instance of the class, such that I can say: c = Sample.new(h) 
and then c.this should return [1,2,3,4,5,6] c.that  should return ['here', 'there', 'everywhere'] c.other should return ’here’
