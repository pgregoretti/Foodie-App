# Foodie
Foodie is an iOS app that lets users see images of food in their local area to find new restaurants. The idea of our application is that our hunger is often visual. Foodie uses the GPS coordinates of the user's phone to call the Yelp API and populate an image grid with photos of food.


When the application first starts, the user is prompted to log in with Google account. Afterwards, the application stores the Google account information to local storage and uses this to welcome the user. The user then sees an image grid view that is populated with images from a Yelp API call based on the GPS coordinates of the phone. 

Clicking on an image takes the user to a restaurant information screen that shows the restaurant name, categories, distance, address, rating, and an image of the restaurant. Clicking “random” prompts a message that tells the user that if they shake the device while on
the grid view screen that a random nearby restaurant information page will show. Shaking the device prompts this segue.

![Foodie preview](https://raw.githubusercontent.com/pgregoretti/Foodie-App/master/foodie_preview.png)

### Note:
As of June 30, 2018, API v2 has be discontinued and v2 endpoints will no longer work. All Yelp applications must switch over to Yelp Fusion. This is something that I plan on updating in the near future.
