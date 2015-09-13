class PagesController < ApplicationController
  force_ssl
  include Devise::Controllers::Rememberable
	before_action :authenticate_brand!, only: [:brand_dashboard]
	before_action :authenticate_shopper!, only: [:shopper_dashboard]

  def home
  	if current_brand
  		redirect_to brand_dashboard_path
  	elsif current_shopper
  		redirect_to shopper_dashboard_path
  	end
  end

  def load

    if params[:signed_payload].present?
      payload = parse_signed_payload

      current_store_hash = payload[:store_hash] 

      @brand = Brand.find_by store_hash: current_store_hash

      remember_me(@brand)      
    end

    redirect_to brand_dashboard_path

  end

  def brand_dashboard

    Bigcommerce.configure do |config|
      config.store_hash   = current_brand.store_hash
      config.client_id    = ENV['BC_CLIENT_ID']
      config.access_token = current_brand.bctoken
    end



    @orders = Bigcommerce::Order.all

  	@current_brand = current_brand
  end

  def shopper_dashboard
  	@current_shopper = current_shopper
  end


  private

  def parse_signed_payload
    signed_payload = params[:signed_payload]
    message_parts = signed_payload.split('.')

    encoded_json_payload = message_parts[0]
    encoded_hmac_signature = message_parts[1]

    payload = Base64.decode64(encoded_json_payload)
    provided_signature = Base64.decode64(encoded_hmac_signature)

    expected_signature = sign_payload(ENV['BC_CLIENT_SECRET'], payload)

    if secure_compare(expected_signature, provided_signature)
      return JSON.parse(payload, symbolize_names: true)
    end

    nil
  end
  # Sign payload string using HMAC-SHA256 with given secret
  def sign_payload(secret, payload)
    OpenSSL::HMAC::hexdigest('sha256', secret, payload)
  end

  # Time consistent string comparison. Most library implementations
  # will fail fast allowing timing attacks.
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end

end
