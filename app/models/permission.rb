class Permission < Struct.new(:user)

  def allow?(controller, action, resource = nil)

    
    return true if user && user.role == "Admin"
    return true if controller == "subscriptions" && action.in?(%w[new create show])
    return true if controller == "plans" && action.in?(%w[index show])
    return true if controller == "user/sessions"
    return true if controller == "user/registrations"
    return true if controller == "devise/sessions"
    return true if controller == "pages"
    return true if controller == "messages"
    # return true if controller == "projects/project_users"
    return true if controller == "devise/invitations"
    return true if controller == "projects" && action.in?(%w[new create show index])
    return true if controller == "projects" && resource && resource.user_id == user.id
    # return true if controller == "projects/project_users" && action.in?(%w[new create show])
    return true if controller == "projects/project_users" && resource && resource.user_id == user.id
    # return true if controller == "projects" && action.in?(%w[index show new])
    
    if user && user.current_project
      pro_user = ProjectUser.where(project_id: user.current_project, user_id: user.id).first
      role = pro_user.role
    else
      role = nil
    end

    main_ctrls = %w[crews events locations pdfs rentals ]
    restricted = %w[budgets ]
    # admin = %w[budgets projects admin admin/users admin/dashboard]

    if role == "Owner"
      return true if controller == "projects"
      return true if controller == "projects/project_users"
      return true if controller.in?(main_ctrls)
      return true if controller.in?(restricted)

    elsif role.in?(["Production Designer", "Decorator", "Assistant Decorator"])
      return true if controller.in?(main_ctrls)
      return true if controller.in?(restricted)

    elsif role.in?([ "Buyer", "Lead Dresser", "Dresser Worker"])
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])

    elsif user
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    end

    false
  end
end

