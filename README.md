## Previewing mailers ##

Visit `http://localhost:3000/rails/mailers/user_mailer/account_activation` to view a preview of the account activation mailer. Substitute in the name of the mailer you wish to see for `account_activation` at the end of the link.

## Running Livereload ##
1. [Install](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-) Chrome browser extension.

2. Run the following:
    ```python
    ➜  evergreen (master●) bundle exec guard                      [ruby-2.1.5]
    14:23:43 - INFO - Guard is using TerminalTitle to send notifications.
    14:23:43 - INFO - Guard::Minitest 2.3.1 is running, with Minitest::Unit 5.5.0!
    14:23:43 - INFO - LiveReload is waiting for a browser to connect.
    14:23:43 - INFO - Guard is now watching at '/Users/devonzuegel/Github/evergreen'
    ```

3. Click the "Enable Livereload" extension button. You should then seen the following in your terminal:
    ```python
    [1] guard(main)> 14:23:45 - INFO - Browser connected.
    ```

Further directions [here](https://github.com/guard/guard-livereload) and [here](http://stackoverflow.com/questions/24290950/guard-livereload-not-reload-browser).

## Misc ##

Consider adding the following to this readme:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...