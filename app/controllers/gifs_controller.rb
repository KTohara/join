class GifsController < ApplicationController
  require 'rest-client'

  before_action :turbo_frame_request_variant, only: :index

  def index
    if params[:q].present?
      tenor_response = RestClient.get(tenor_url)
      gifs = JSON.parse(tenor_response)
      @results = gifs['results'].map { |gif| gif['media_formats']['tinygif']['url'] }
    else
      return
    end
  end

  private

  def turbo_frame_request_variant
    if turbo_frame_request?
      request.variant = :turbo_frame
    else
      redirect_to root_path
    end
  end

  def tenor_url
    # https://developers.google.com/tenor/guides/endpoints

    query = params[:q]
    key = Rails.application.credentials.dig(:tenor, :key)
    base_url = 'https://tenor.googleapis.com/v2/search?'
    content_filter = 'medium'
    media_filter = 'minimal'
    ar_range = 'standard'
    limit = '10'
    
    "#{base_url}&key=#{key}&content_filter=#{content_filter}&media_filter=#{media_filter}&ar_range=#{ar_range}&q=#{query}&limit=#{limit}"
  end
end
