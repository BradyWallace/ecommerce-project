Rails.configuration.stripe = {
  publishable_key: "pk_test_51OAJqrKF3OpjgS9M9FX2XeV8We8gFXMtg32JnHrSwj0Uz6WJ4DZpKCzxO1SxkVkUvPO5g7KPyKPyZ1P0kvggBf6i00EATTgL1N",
  secret_key:      "sk_test_51OAJqrKF3OpjgS9MPVKHtQ2Jc7n4qUb0RqsaVU1GfuI6suV5B2HKSosLz79EdJNU8ACwO1yWsJLHGmodziOegETs00cIkgWe8e"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
