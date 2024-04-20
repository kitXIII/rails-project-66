# frozen_string_literal: true

module ApplicationHelper
  BOOTSTRAP_ALERT_CLASSES = {
    notice: 'alert-info',
    alert: 'alert-danger'
  }.freeze

  def flash_classes(level)
    "alert #{BOOTSTRAP_ALERT_CLASSES[level.to_sym] || BOOTSTRAP_ALERT_CLASSES[:notice]}"
  end
end
