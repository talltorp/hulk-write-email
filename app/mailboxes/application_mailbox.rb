class ApplicationMailbox < ActionMailbox::Base
  include Rails.application.routes.url_helpers

  routing /^support@/i => :support
  routing /^hulk@/i => :boring_email
end
