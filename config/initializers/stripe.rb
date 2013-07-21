Stripe.api_key = "87BXBVGKx1Ov0y3hSHzgmxjhpcocAqPl"
STRIPE_PUBLIC_KEY = "pk_OClK9sVkWme3lRSGIQgbpT70r4jXs"

Rails.configuration.stripe = {
  :publishable_key => STRIPE_PUBLIC_KEY,
  :secret_key => Stripe.api_key
}
