module ApplicationHelper
	def print_image(url)
		# url = Rails.application.assets.find_asset(url).nil? ? nil : url
		if url && url.length > 1
		  image_tag url
		  # logger.info "############# URL ##################}"
		  # logger.info "#{url}"
		else
			image_tag 'http://www.thekpes.com/down/placeholder.png'
		end
	end

end
