# Two Man - Two Factor

Generally everyone should have their own login however this is not always an
option on for example a GitHub.com account for your teams bot. Two Man 2FA
implements the

### How it works via SMS:

**New Token**
- Register a 2fa token via POST /enlist API
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
    You: hubot 2fa enlist github base32secret3232
    Hubot: I added github to the arsenal and have text a launch code
    to the principals
  ```

**Request a Token**
- Ask hubot!

  ```
    You: hubot 2fa launch github
    Hubot: @you I have initiated the countdown, awaiting final orders.
  ```

- The rest of your team then receive their text messages as per the SMS flow

## Configuration

We use environment variables for easy deployment to Heroku in development you
can use foreman and dotenv

SECRET_KEY_BASE=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
PRINCIPALS=bob:12345,bill:67891,jill:19865
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=yyyyyyyyyyyyyyyyyyyyyyyyy
