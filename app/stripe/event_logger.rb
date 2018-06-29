class EventLogger
  def initialize(logger)
    @logger = logger
  end

  def call(event)
    @logger.info "STRIPE:#{event.type}:#{event.id}"
  end
end
