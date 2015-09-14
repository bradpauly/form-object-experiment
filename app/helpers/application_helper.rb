module ApplicationHelper
  def error_message_tag(messages)
    if messages.any?
      content_tag(:div, messages.first, class: "validation-hint")
    end
  end
end
