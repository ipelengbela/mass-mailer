require "dotenv"
require "mail"

Dotenv.load

class Mailer
  def initialize opts
    @username = opts[:username]
    @password = opts[:password]
    @email_body = opts[:email_body]
    @email_from = opts[:email_from]
    @email_subject = opts[:email_subject]
    @delay_between_email = opts[:delay_between_email] || 2
    @content_type = opts[:content_type]
  end

  def file_include? filename, str
    File.open(filename, "r") do |file|
      file.each do |line|
        return true if line.include?(str)
      end
    end
    false
  end

  def deliver
    options = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => @username,
      :password             => @password,
      :authentication       => "plain",
      :enable_starttls_auto => true,
      :enable_ssl           => true
    }

    Mail.defaults do
      delivery_method :smtp, options
    end

    File.readlines("email_list.txt").each do |email_to|
      if !file_include? "email_used.txt", email_to
        mail = Mail.new do
          to           email_to
          content_type @content_type || "text/plain; charset=UTF-8; format=flowed"
          from         @email_from
          subject      @email_subject
          body         @email_body
        end
        mail.deliver
        File.open("email_used.txt", "a+") { |f| f.puts(email_to) }
        puts "Sent email to: #{email_to}"
        sleep @delay_between_email
      end
    end
  end
end

email_body = <<-EMAIL_BODY
Dear Lorem,

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cum ullam,
voluptate alias doloremque voluptatum veniam voluptates aspernatur officia harum, perferendis neque iste quis quibusdam asperiores. Distinctio dolorem illo aperiam culpa.

Thanks,
Lorem
EMAIL_BODY

mail = Mailer.new({
  username: ENV['GMAIL_USERNAME'],
  password: ENV['GMAIL_PASSWORD'],
  email_from: 'Lorem Ipsum <lorem@ipsum.com>',
  email_subject: 'Lorem Ipsum',
  email_body: email_body,
  delay_between_email: 5
})
mail.deliver