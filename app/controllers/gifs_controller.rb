class GifsController < ApplicationController
  require 'rest-client'

  before_action :turbo_frame_request_variant, only: :index

  def index
    @form_id = gif_params[:form_id]
    tenor_response = RestClient.get(url)
    gifs = JSON.parse(tenor_response)
    @results = gifs['results'].map { |gif| gif['media_formats']['tinygif']['url'] }
  end

  private

  def gif_params
    params.permit(:q, :form_id)
  end

  def turbo_frame_request_variant
    if turbo_frame_request?
      request.variant = :turbo_frame
    else
      redirect_to root_path
    end
  end

  def url
    query = gif_params[:q]

    if query.present? && query.ascii_only?
      tenor_url(:search, query)
    else
      tenor_url(:featured)
    end
  end

  def tenor_url(type, query = nil)
    # https://developers.google.com/tenor/guides/endpoints
    
    key = Rails.application.credentials.dig(:tenor, :key)
    base_url = tenor_base_url(type)
    content_filter = 'medium'
    media_filter = 'minimal'
    ar_range = 'standard'
    limit = 30

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
