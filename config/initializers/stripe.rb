Rails.configuration.stripe = {
  :publishable_key => Rails.application.credentials[Rails.env.to_sym][:stripe][:publishable_key],
  :secret_key      => Rails.application.credentials[Rails.env.to_sym][:stripe][:secret_key]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secrets = [
  Rails.application.credentials.dig(:stripe_signing_secret, :production),
  Rails.application.credentials.dig(:stripe_signing_secret, :staging),
  Rails.application.credentials.dig(:stripe_signing_secret, :development)
]

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', ChargeSucceeded.new
  events.subscribe 'charge.failed', ChargeFailed.new
  events.all EventLogger.new(Rails.logger)
end
