class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@qiitan-debug-beginner.jp', reply_to: 'support@qiitan-debug-beginner.jp'
  layout 'mailer'
end
