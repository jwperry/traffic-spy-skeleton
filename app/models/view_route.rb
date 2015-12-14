class ViewRoute

  def self.event_route(application, event)
    (application == nil || event == nil) ? (:event_error) : (:event_data)
  end

end
