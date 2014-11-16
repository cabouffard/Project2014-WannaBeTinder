module UserHelper
  def user_avatar(user)
    image_tag(user.picture? ? user.picture_url(:default) : "blank-avatar.png", alt: "Avatar", class: "user-avatar user-#{user.profession}-avatar img-thumbnail")
  end

  def small_user_avatar(user)
    image_tag(user.picture? ? user.picture_url(:small) : "blank-avatar.png", alt: "Avatar", style: "width: 32px; height: 32px")
  end
end

