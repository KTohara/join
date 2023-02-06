module ApplicationHelper
  include Pagy::Frontend

  def animation(animate, animation_class)
    animation_class if animate == true
  end

  def animate_logo_sm
    'relative isolate overflow-hidden rounded-full
    hover:before:animate-shimmer ease-in-out duration-200
    before:absolute before:inset-0 before:bg-gradient-to-r before:from-transparent
    before:via-white/50 before:to-transparent before:-translate-x-full'
  end

  def animate_logo_lg
    'relative transition-all w-min-content
    before:w-0 before:h-[1px] before:absolute before:bottom-0 before:right-0 before:bg-white before:transition-all before:duration-500
    hover:before:w-full hover:before:left-0 hover:before:bg-orange-500'
  end
end
