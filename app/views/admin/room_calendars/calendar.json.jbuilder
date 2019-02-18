json.array! @room_calendars do |event|
  if event.title.present?
    json.id event.id
    json.title event.title
    json.description event.day_info
    json.start event.day
    json.end event.day.tomorrow
    json.url event.url
    json.textColor "black"
    json.color event.color
  end
end
