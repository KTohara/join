module ApplicationHelper
  include Pagy::Frontend

  def animation(animate, animation_class)
    animation_class if animate == true
  end
end
