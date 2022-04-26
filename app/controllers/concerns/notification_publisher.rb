module Concerns
  module NotificationPublisher
    extend ActiveSupport::Concern

    def send_notify(name, payload)
      ActiveSupport::Notifications.instrument(name, payload)
    end
  end
end
