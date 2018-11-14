module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one

    rescue_from ActiveRecord::RecordNotFound do |error|
      render json: { message: error.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      render json: { message: error.message }, status: :unprocessable_entity
    end
  end

  private

  def four_twenty_two(error)
    render json: { message: error.message }, status: :unprocessable_entity
  end

  def four_ninety_eight(error)
    render json: { message: error.message }, status: :invalid_token
  end

  def four_zero_one(error)
    render json: { message: error.message }, status: :invalid_token
  end

  def unauthorized_request(error)
    render json: { message: error.message }, status: :unauthorized
  end
end
