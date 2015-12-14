class ViewRoute

  def self.event_route(application, event)
    if application.nil?
      :application_error
    elsif event.nil?
      :event_error
    else
      :event_data
    end
  end

  def self.events_index_route(application)
    if application.nil?
      :application_error
    elsif application.events.all.empty?
      :event_index_error
    else
      :event_index
    end
  end

  def self.url_route(application, url)
    if application.nil?
      :application_error
    elsif url.nil?
      :url_data_error
    else
      :url_data
    end
  end

  def self.application(application)
    if application.nil?
      :application_error
    elsif application.payloads.all.empty?
      :payload_error
    else
      :application_details
    end
  end
end
