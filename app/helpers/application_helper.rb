module ApplicationHelper
  include Pagy::Frontend

  def animation(animate, animation_class)
    animation_class if animate == true
  end

  def main_layout
    'container mx-auto sm:mt-12 mt-2 max-w-2xl' if user_signed_in?
  end

  def formatted_date(object)
    object_creation_time = object.created_at
    if object_creation_time < 3.days.ago
      object.created_at.strftime('%B %e, %Y at %l:%M %p')
    else
      time_ago_in_words(object_creation_time)
    end
  end
end
