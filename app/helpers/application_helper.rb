module ApplicationHelper
  include Pagy::Frontend

  def authenticate_admin_role
    current_user && (current_user.Admin? || current_user.Super_Admin?)
  end

  def format_date(post)
    if I18n.locale == :en
      if post.hide_day && post.hide_month
        post.date.strftime("%Y") 
      elsif post.hide_day
        post.date.strftime("%b %Y")  
      elsif post.hide_month
        post.date.strftime("%d %Y")  
      else
        post.date.strftime("%d %b %Y")
      end
    elsif I18n.locale == :ar
      if post.hide_day && post.hide_month
        post.date.strftime("%Y") 
      elsif post.hide_day
        l(post.date, format: "%Y %b")  
      elsif post.hide_month
        l(post.date, format: "%Y %d")  
      else
        l(post.date, format: "%Y %b %d")
      end
    end
  end
end
