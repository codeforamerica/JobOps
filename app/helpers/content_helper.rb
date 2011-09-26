module ContentHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.find_by_id(current_user.id)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
