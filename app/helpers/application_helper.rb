module ApplicationHelper
  include Pagy::Frontend

  def animation(animate, animation_class)
    animation_class if animate == true
  end

  def animate_logo
    'relative isolate overflow-hidden rounded-full
    hover:before:animate-shimmer hover:scale-105 ease-in-out duration-200
    before:absolute before:inset-0 before:bg-gradient-to-r before:from-transparent
    before:via-white/50 before:to-transparent before:-translate-x-full'
  end
end
