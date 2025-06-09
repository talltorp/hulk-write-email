require 'net/http'
require 'json'

class TurnstileVerifier
  URI = URI("https://challenges.cloudflare.com/turnstile/v0/siteverify")
  MAX_RETRIES = 3

  attr_reader :token, :ip

  def initialize(token, ip)
    @token = token
    @ip = ip
  end

  def verify
    return false if token.blank?

    MAX_RETRIES.times do |attempt|
      begin
        response = send_request

        if response["success"] == true
          return true
        else
          Rails.logger.warn "Turnstile verification failed: #{response["error-codes"].inspect}"
          sleep(2**attempt) if attempt < MAX_RETRIES - 1 
        end
      rescue StandardError => e
        Rails.logger.error "Turnstile verification error: #{e.message}"
        sleep(2**attempt) if attempt < MAX_RETRIES - 1
      end
    end

    false
  end

  private

  def send_request
    request = Net::HTTP::Post.new(URI)
    request.set_form_data({
      "secret" => ENV.fetch("TURNSTILE_SECRET_KEY"),
      "response" => token,
      "remoteip" => ip
    })

    response = Net::HTTP.start(URI.hostname, URI.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end 