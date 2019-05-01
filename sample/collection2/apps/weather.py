#!/usr/bin/env python
""" Script that prints out tomorrow's weather forecast, using the Yahoo Weather API.

You'll need to get your location's WOEID, which you can get from entering your 
location in the form on http://weather.yahoo.com/ - currently where it says 
'Enter city of zip code'. 

The WOEID numerical id will be in the URL of the page you get redirected to 
after submitting the form e.g. in the URL 
http://weather.yahoo.com/united-kingdom/england/newcastle-upon-tyne-30079/ the 
WOEID is 30079. """

import json
import urllib2
import os

def get_weather(woeid):
    url = 'http://weather.yahooapis.com/forecastjson?w=%d&u=c' % (woeid)
    return json.load(urllib2.urlopen(url))

if __name__ == '__main__':
    newcastle = 30079
    weather = get_weather(newcastle)
    location = weather['location']
    tomorrow = weather['forecast'][1]
    print 'location: %s, %s' % (location['city'], location['state_abbreviation'])
    print 'forecast for tomorrow: %s' % tomorrow['condition']
    print 'high: %d' % tomorrow['high_temperature']
    print 'low: %s' % tomorrow['low_temperature']
