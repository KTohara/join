module ApplicationHelper
  include Pagy::Frontend

  def close_window(js_controller)
    "click->#{js_controller}#close click@window->#{js_controller}#close touchend@window->#{js_controller}#close"
  end
end
