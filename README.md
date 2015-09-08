# Mass Mailer
Easy and convenient tool for sending mass mail to your clients, using Gmail.

#### Getting started
Create a new file called `.env` and add your Gmail login credentials

```
Line 1: GMAIL_USERNAME=myusernamehere
Line 2: GMAIL_PASSWORD=mypasswordhere
```

Add your emails to `email_list.txt`

```
Line 1: foo@bar.com
Line 2: peter@parker.com
Line 3: sponge@bob.com
```

Format your email from `mailer.rb`

```
delay_between_email = 5 # seconds
email_from          = "Lorem Ipsum <lorem@ipsum.com>"
email_subject       = "Lorem Ipsum?"
email_body          = <<-EMAIL_BODY
Dear Lorem,

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cum ullam,
voluptate alias doloremque voluptatum veniam voluptates aspernatur officia harum, perferendis neque iste quis quibusdam asperiores. Distinctio dolorem illo aperiam culpa.

Thanks,
Lorem
EMAIL_BODY
```

When you're finish, run the mailer from the Terminal, or Command-line using `ruby mailer.rb`.