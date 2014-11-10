module ApplicationHelper
  def title(title)
    content_for(:title, title)
  end

  def reverse_locale(locale)
    locale.to_sym == :fr ? :en : :fr
  end

  # Text & Icon

  def icon(*classes)
    raw("<i class=\"fa #{classes.join(" ")}\"></i>")
  end

  def icon_and_text(icon_class, text)
    icon_class << " fa-prepend"
    raw("#{icon(icon_class)}#{text}")
  end

  def text_and_icon(text, icon_class)
    icon_class << " fa-append"
    raw("#{text}#{icon(icon_class)}")
  end
end
