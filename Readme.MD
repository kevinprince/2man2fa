# Two Man - Two Factor

The idea of this app is to allow you to share two factor tokens for applications
which have limited ability to sanely create multiple logins or to protect your
master account for example a GitHub.com account for your teams bot.

### How it works via SMS:

**New Token**
- Register a 2fa token via POST /register
- The 2fa code is sent via SMS to the registered users

**Request a Token**
- Send an SMS to your Twilio number
- A signing request is sent to the other members of your team to approve
- Once another team member approves the request it is sent via SMS to the requester

## How it works via hubot:

**New Token**
- Tell Hubot to register a token:

  ```
    You: hubot 2fa add github base32secret3232
    Hubot: I registered github and text you the 2FA token to complete setup
  ```

**Request a Token**
- Ask hubot!

  ```
    You: hubot 2fa token github
    Hubot: @user2 @user3 is this ok?
    User2: hubot 2fa approve
    Hubot: @user1 I text you the 2FA code
  ```
