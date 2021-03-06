module ApplicationHelper
  #хелпер для заголовка страницыы
  def full_title(page_title)
    base_title = "Интерактивные списки"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title} "
    end
  end
  #хелпер адреса текущей страницы
  def absolute_url
    request.original_url
  end

  def display_avatar(user)
    if user.avatar.blank?
      image_tag("user.svg")
      else
      image_tag(user.avatar)
     end
  end
end
