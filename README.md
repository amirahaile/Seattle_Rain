# When did it last rain in Seattle?
As of today, 04/25/15, I'll be moving to Seattle, WA in eight days. When people learn this, the conversation invariably comes to how often it rains in Seattle. I thought I'd get some API practice and make a little web app that tells you how long it's been since it last rained in Seattle.

### Issues
This is my first time working with an API, so I'd love to get some feedback.

* The way my program works, the API is pinged for every day it has not rained. So if it's Tuesday and it hasn't rained since Sunday, one user could ping the API three times. This will add up. While I was debugging my code, I exceeded the daily limit by 563 calls and the by-minute limit by 370 calls. I'd like to figure out how to check if the API was already pinged for that day (according to PST) and save the result to limit the daily calls. 
* My code feels bulky. The performance isn't affected (since Seattle rains so frequently it doesn't have to loop much) but I'd like to trim it up a bit; make it more elegant. 

#### [Wunderground API](http://www.wunderground.com/weather/api/)
