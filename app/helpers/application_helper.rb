module ApplicationHelper
  MAILER_FROM_ADDRESS = 'admin@360showings.com'
  SHOWINGS_ADMIN = ['endymionjkb@gmail.com', 'brian@brianwoodard.com']
  SMTP_USERNAME = 'lynx@perk.es'
  SMTP_PASSWORD = '^qG2452!'

  PHONE_LEN = 14
  STATE_LEN = 2
  ZIP_LEN = 10
  MLS_ID_LEN = 8

  # Plus DC and territories
  US_STATES = %w(AK AL AR AS AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MP MS 
                 MT NC ND NE NH NJ NM NV NY OH OK OR PA PR RI SC SD TN TX UT VA VI VT WA WI WV WY )
  EMAIL_REGEX = /\A\w.*?@\w.*?\.\w+\z/
  US_PHONE_REGEX = /\A\(\d\d\d\) \d\d\d\-\d\d\d\d\z/
  US_ZIP_REGEX = /\A\d\d\d\d\d(-\d\d\d\d)?\z/
  URL_REGEX = /\A((http|https)\:\/\/)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9\-\._\?\,\'\/\\\+&amp;%\$#\=~])*[^\.\,\)\(\s]\z/
  FACEBOOK_REGEX = /\A(http\:\/\/)?(www\.)?facebook\.com\/\S+\z/

  INVALID_EMAILS = ["joe", "joe@", "gmail.com", "@gmail.com", "@Actually_Twitter", "joe.mama@gmail", "fish@.com", "fish@biz.", "test@com"]
  VALID_EMAILS = ["j@z.com", "jeff.bennett@pittsburghmoves.com", "fish_42@verizon.net", "a.b.c.d@e.f.g.h.biz"]
end
