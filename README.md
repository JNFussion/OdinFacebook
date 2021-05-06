# README
## OdinFacebook
This is the final proyect from [The odin Proyect course of Ruby on Rails](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project). It's a simplified version of Facebook. The project has a list of assignment that I have to implement on my own.<br/><br/>
The project is deployed on [Heroku](https://www.heroku.com/home) ~~> OdinFacebook [here](https://odin-notfacebook.herokuapp.com).

### Features:

- Users can login/sign up. The  authentication process goes through [Devise gem](https://github.com/heartcombo/devise). Devise adds [OmniAuth](https://github.com/omniauth/omniauth) support, which is used to allow a user to sign in with their real Facebook account.<br/>
A user have some basic info such as first name, last name, birthday, etc. And, they have contact info such as email and a phone number. Also a user can have a profile picture, they have to upload it otherwise their profile picture will be grab from their email using [Gravtastic gem](https://github.com/chrislloyd/gravtastic).<br/>

- Users can send friend request to establish a friendship with another user. Incoming requests will appear in the home page of the user on the notification box.

- Users can create posts. These can display text, an image or both. Posts can be liked or disliked by the current user. He can comment on posts or comment on comments.

- The home page shows all the recent posts from the current user and users she is friends with.The profile page displays user's info, posts and friends.

- I have used [bulma](https://bulma.io/) as a CSS framework. To be honest the website is prety ugly.

- I have uses Active Storage to upload images and [Cloudinary](https://cloudinary.com) as a cloud storage service.

- I have set up a mailer to send a welcome email when a new user signs up.
