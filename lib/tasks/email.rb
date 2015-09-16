require 'sendgrid-ruby'

def sendMail (to, from, subject, body)
  # using SendGrid's Ruby Library - https://github.com/sendgrid/sendgrid-ruby
  client = SendGrid::Client.new(api_user: 'Solvify', api_key: 'blowme000!!!')

  email = SendGrid::Mail.new do |m|
    m.to      = to
    m.from    = from
    m.subject = subject
    m.html    = body
  end

  client.send(email)
end

