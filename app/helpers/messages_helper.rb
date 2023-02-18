module MessagesHelper
  def message_date(obj)
    if obj.created_at == Date.today - 1
      obj.created_at.strftime('Yesterday at %l:%M%P')
    elsif obj.created_at >= Time.zone.now.beginning_of_day
      obj.created_at.strftime('Today at %l:%M%P')
    else
      obj.created_at.strftime('%D at %l:%M%P')
    end
  end
end
