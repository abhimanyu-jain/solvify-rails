def send_sms(phone_no, body)
  message = URI.encode(body)
  uri = URI("http://123.63.33.43/blank/sms/user/urlsmstemp.php?username=kapbulk&pass=kap@user!23&senderid=KAPMSG&message="+message+"&dest_mobileno="+phone_no.to_s+"&response=Y")
  res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')
end