class Permission < Struct.new(:user)

  def allow?(controller, action, resource = nil)

    
    return true if user && user.role == "Admin"

   
    return true if controller == "subscriptions" && action.in?(%w[new create show])
    return true if controller == "plans" && action.in?(%w[index show])
    return true if controller == "user/sessions"
    return true if controller == "user/registrations"
    return true if controller == "devise/sessions"
    return true if controller == "pages"
    

    

    main_ctrls = %w[crews events locations pdfs rentals ]
    restricted = %w[budgets projects ]
    # admin = %w[budgets projects admin admin/users admin/dashboard]

    if user && user.role == "Production Designer"
      return true if controller.in?(main_ctrls)
      return true if controller.in?(restricted)
    elsif user && user.role == "Decorator"
      return true if controller.in?(main_ctrls)
      return true if controller.in?(restricted)
    elsif user && user.role == "Assistant Decorator"
      return true if controller.in?(main_ctrls)
      return true if controller.in?(restricted)

    elsif user && user.role == "Buyer"
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    elsif user && user.role == "Lead Dresser"
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    elsif user && user.role == "Dresser"
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    elsif user && user.role == "Worker"
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    elsif user
      return true if controller.in?(main_ctrls)  && action.in?(%w[show index sets])
    end

    false
  end
end


 # return true if controller == "sites"  && resource && resource.employer_id == employer.id
      # return true if controller == "employers" && resource && resource.id == employer.id
      # return true if controller == "workers"   && resource && resource.employer_id == employer.id
      # return true if controller.in?(%w[emergencies certificates orientations sjps swps violations wcbs])