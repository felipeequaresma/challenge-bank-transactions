ActiveSupport::Notifications.subscribe('deposit') do |name, started, finished, unique_id, payload|
  Rails.logger.debug("[ActiveSupport::Notifications] [deposit] [payload: #{payload.inspect}]")
  
  Accounts::CreateExcerpt.call(payload)
end

ActiveSupport::Notifications.subscribe('withdrawal') do |name, started, finished, unique_id, payload|
  Rails.logger.debug("[ActiveSupport::Notifications] [withdrawal] [payload: #{payload.inspect}]")
  
  Accounts::CreateExcerpt.call(payload)
end

ActiveSupport::Notifications.subscribe('transfer') do |name, started, finished, unique_id, payload|
  Rails.logger.debug("[ActiveSupport::Notifications] [transfer] [payload: #{payload.inspect}]")
  
  Accounts::CreateExcerpt.call(payload)
end
