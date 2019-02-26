module ApplicationHelper
   # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def user_info(user)
    user_info = "#{user.name} (@#{user.primary_name})"
  end
end
