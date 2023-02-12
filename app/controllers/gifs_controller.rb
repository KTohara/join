class GifsController < ApplicationController
  require 'rest-client'

  before_action :turbo_frame_request_variant, only: :index

  def index
    @form_id = params[:form_id]
    url = params[:q] ? tenor_url(:search, params[:q]) : tenor_url(:featured)

    tenor_response = RestClient.get(url)
    gifs = JSON.parse(tenor_response)
    @results = gifs['results'].map { |gif| gif['media_formats']['tinygif']['url'] }
  end

  private

  def turbo_frame_request_variant
    if turbo_frame_request?
      request.variant = :turbo_frame
    else
      redirect_to root_path
    end
  end

  def tenor_url(type, query = nil)
    # https://developers.google.com/tenor/guides/endpoints
    key = Rails.application.credentials.dig(:tenor, :key)
    base_url = tenor_base_url(type)
    content_filter = 'medium'
    media_filter = 'minimal'
    ar_range = 'standard'
    limit = 12

    "#{base_url}&key=#{key}&content_filter=#{content_filter}&media_filter=#{media_filter}&ar_range=#{ar_range}&q=#{query}&limit=#{limit}"
  end

  def tenor_base_url(type)
    case type
    when :featured
      'https://tenor.googleapis.com/v2/featured?'
    when :search
      'https://tenor.googleapis.com/v2/search?'
    end
  end
end
