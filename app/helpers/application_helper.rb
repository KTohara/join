module ApplicationHelper
  include Pagy::Frontend

  def animation(animate, animation_class)
    animation_class if animate == true
  end

  def main_layout
    'container mx-auto sm:mt-12 mt-2 max-w-2xl' if user_signed_in?
  end
end
