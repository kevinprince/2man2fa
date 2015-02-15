# Two Man - Two Factor

The idea of this app is to allow you to share two factor tokens for applications
which have limited ability to sanely create multiple logins or to protect your
master account for example a GitHub.com account for your teams bot.

### How it works via SMS:

**New Token**
- Register a 2fa token via POST /enroll API
- The 2fa code is sent via SMS to the registered users

**Request a Token**
- Send an SMS to your inbound number

  ```
    SMS: +447123123456
    launch github
  ```

- A signing request is sent to the other members of your team to approve

  ```
    user1 has requested launch keys for github do you concur? reply with 'go jewhg'
    to concur or 'abort jewhg' to abort
  ```

- Once another team member approves / denies the request it is sent via SMS to
  the requester

  ```
    launch was confirmed by user2 Your launch token is 123456
  ```

  or

  ```
    launch was denied by user2. Maybe check your following orders before trying
    again
  ```



## How it works via hubot:

**New Token**
- Tell Hubot to register a token:

  ```
    You: hubot 2fa silo github base32secret3232
    Hubot: I added github to the arsenal and have text you the launch code to
    complete setup
  ```

**Request a Token**
- Ask hubot!

  ```
    You: hubot 2fa launch github
    Hubot: @user2 @user3 do you confirm the order?
    User2: hubot 2fa i concur
    Hubot: @user1 I have text you the launch code
  ```

## Configuration

We use environment variables for easy deployment to Heroku in development you
can use foreman and dotenv

SECRET_KEY_BASE=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=yyyyyyyyyyyyyyyyyyyyyyyyy
