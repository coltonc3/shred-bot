# Shred Bot


Ski resorts now require reservations to be made in advance of skiing to prevent the spread of Covid. Making these reservations often gets competitive as everyone tries to go all on the same day. People are always cancelling and re-booking to get their spot. I found it tedious always having to check the Ikon website to see if any days had opened up at my resort.

Outside of the annoyance that comes with making ski reservations I decided I wanted to learn more about using Selenium WebDriver in applications.  I've used it at work for feature tests but honestly didn't quite understand what was going on when I got stuck.

Note: This script only works with resorts that allow reservations to be made directly on the Ikon site.

---

## Usage

The goal of this project was to make the script run at time intervals specified by the user. This can be done using a Cron job.  If you're unfamiliar with Cron jobs you can learn about them [here](https://ostechnix.com/a-beginners-guide-to-cron-jobs/).

You must install [WebDriver binaries](https://www.selenium.dev/documentation/en/selenium_installation/installing_webdriver_binaries/) on your machine before anything else. 

Change to the project directory and run `bundle install` to install dependencies. Then create a file called `creds.rb` with the following information for logging into your Ikon account and choosing a mountain:  
```
IKON_EMAIL="your.email@example.com"
IKON_PW="your-password"
RESORT="your favorite mountain"
MONTH="month"
DAY="#"
```
Save the file, open Terminal and do the following:  
`crontab -e`. 
On a new line, enter    
`*/30 * * * * ruby your/path/to/shred_bot.rb` (this runs the script every 30 mins, change to whatever you want)   
Allow the crontab to be installed. Then run `crontab -l` to make sure it saved properly. This should show all your Cron jobs.  

Set-up finished. 
