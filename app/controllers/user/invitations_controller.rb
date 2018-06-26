class User::InvitationsController < Devise::InvitationsController

 def update
  super
  project = current_user.projects.first.id
  logger.info "#################  INVITATION ##########################"
		logger.info "#################  #{current_user.email} ##########################"
		logger.info "#################  #{project} ##########################"
  current_user.update(current_project: project)
 end

end