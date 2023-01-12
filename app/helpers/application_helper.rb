module ApplicationHelper
  include Pagy::Frontend

  def toggle_popup(stimulus_controller)
    "click->#{stimulus_controller}#toggle click@window->#{stimulus_controller}#close touchend@window->#{stimulus_controller}#close"
  end
end
