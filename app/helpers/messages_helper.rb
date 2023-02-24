module MessagesHelper
  def message_date(obj)
    time = obj.created_at
    if time == Date.today - 1
      local_time(time, 'Yesterday at %l:%M%P')
    elsif time >= Time.zone.now.beginning_of_day
      local_time(time, 'Today at %l:%M%P')
    else
      local_time(time, '%D at %l:%M%P')
    end
  end
end
