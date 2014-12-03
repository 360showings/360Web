MAILCHIMP_DEFAULT_TIMEOUT = 15
# Increase timeout for large batch operations
MAILCHIMP_UPDATE_TIMEOUT = 60
# In case we ever have *lots* of users, build this in now so that batch updates never crash/timeout
USER_BATCH_SIZE = 1000

DOUBLE_OPTIN_POLICY = ENV['DOUBLE_OPTIN'].nil? ? false : ActiveRecord::ConnectionAdapters::Column.value_to_boolean(ENV['DOUBLE_OPTIN'])

Gibbon::API.api_key = ENV['GIBBON_KEY'].nil? ? '8a1e5f09752678bbf0d8b5661892ad30-us9' : ENV['GIBBON_KEY']
Gibbon::API.timeout = MAILCHIMP_DEFAULT_TIMEOUT
# When this is false, it will set error fields in the reply on API calls
Gibbon::API.throws_exceptions = false
