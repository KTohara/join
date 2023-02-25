module MessagesHelper
  def message_date(obj)
    time = obj.created_at
    if time >= 1.minute.ago
      'Just now'
    elsif time == Date.today - 1
      local_time(time, 'Yesterday at %l:%M%P')
    elsif time >= Time.zone.now.beginning_of_day
      local_time(time, 'Today at %l:%M%P')
    else
      local_time(time, '%-m/%-e/%y at %l:%M%P')
    end
  end
end
