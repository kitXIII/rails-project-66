# frozen_string_literal: true

# env variable SENTRY_DSN is used
Sentry.init do |config|
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.excluded_exceptions += [
    'ActionController::RoutingError',
    'ActionController::UnknownFormat',
    'ActiveRecord::RecordNotFound'
  ]

  config.traces_sample_rate = 1.0
end
