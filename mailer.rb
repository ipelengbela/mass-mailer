require "dotenv"
require "mail"

Dotenv.load

options = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => ENV["GMAIL_USERNAME"],
  :password             => ENV["GMAIL_PASSWORD"],
  :authentication       => "plain",
  :enable_starttls_auto => true,
  :enable_ssl           => true
}

Mail.defaults do
  delivery_method :smtp, options
end

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

File.readlines("email_list.txt").each do |email_to|
  mail = Mail.new do
    content_type "text/plain; charset=UTF-8; format=flowed"
    from         email_from
    to           email_to
    subject      email_subject
    body         email_body
  end

  mail.deliver
  puts "Sent email to: #{email_to}"
  sleep delay_between_email
end