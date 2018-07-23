class PagesController < ApplicationController
	skip_before_action :authenticate_user!
    def show
    	render template: "pages/#{params[:page]}"
    end

    def landing

    		render "landing" 
    	
    end
  end  