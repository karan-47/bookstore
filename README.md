# README

## Link to the Deployed Application


## Admin login
* email: admin@gmail.com
* password: admin

_Note_
* For this version of the app, we decided to make Admin a special user
* Admin user is created through database in RubyMine with the above login info

## Setting Up
* Clone this repository<br>

https://github.ncsu.edu/kgala2/bookstore

* Go to the directory<br>

BookShopping

* Install required gems

bundle install

* Run the database migration to your system

rails db:migrate

* Run the seed to get the required data

rails db:seed

* Finally, run the server and open the localhost in your browser

rails server


## Login and Sign-up
* Initial page starts with `login` and `sign-up` buttons
* `login` requires email and password
* `sign-up` required info is indicated on the page
* After `sign-up` user will need to login again to access main page

## How to access the application
* User has to sign-up by Clicking on the http://127.0.0.1:3000/signup
* A signed in user has to login to access the profile and buy a book
* A user has to click on the "View Books" to see all the available books on the website. [http://127.0.0.1:3000/books]
* A user can access his/her transactions by clicking on the "My Transactions" tab [http://127.0.0.1:3000/transactions]
* A user can access their account by clicking on the "My Account" tab.
* A user can access their reviews by clicking on the "My Reviews" tab
* A user can buy a book after viewing the books by clicking on the "Buy" button 
* A user can see, edit and destroy the book by clicking on the respective buttons.
* A user can review the book with a min-1 and max-5 by clicking on the "Review this book" tab. [http://127.0.0.1:3000/reviews/]
* A user can filter the reviews based on the book name and user. [http://127.0.0.1:3000/reviews/]

## User and Admin actions

### User
* Has the following functionalities
  * View Books
  * My Transactions
  * My Account
  * My Reviews
  * Logout
  * HomePage
  * Can sign up for a new account
  * Login with username and password
  * Edit her/his own profile
  * Delete their own account
  * Can View all the books that are available on the website
  * Can List books that have an average rating over a certain amount.
  * Can List books written by a specific author.
  * Can Buy a book or books
  * Can Check their own purchase history
  * Can Write a review of a book
  * Can Edit the review he/she wrote, but should not be able to edit reviews that were written by
    other users.
  * Can List reviews written by a specific user
  * Can List reviews written for a specific book

### Admin

### Reviews
* Has the following functinalities
  * Can Log in with a username and password.
  * Can Edit her/his own profile - should not be able to update ID, username, and password.
  * Can Admin should not be able to delete the admin account
  * Can View all the books that are available on the website
  * Can List books written by a specific author.
  * Can View all the users signed up for the website
  * Can List reviews written by a specific user
  * Can List reviews written for a specific book
  * Can Create/view/edit/delete users
  * Can Create/view/edit/delete books.
  * Create/view/edit/delete reviews

### Transactions
* Has the following functionalities:
  * Price should be automatically calculated when buying books.
  * Stock should be recalculated after each transaction.

### Extra functionalities
* Implemented Race condition to not allow multiple users to make the same transaction when the book is almost out of stock
* Implemented Cart functionality to allow user to add multiple books at the same time and buy
* Implemented Forms Pre-filling to allow user to pre-fill the forms during the transaction time.