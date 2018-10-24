class StaticPagesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@ed = EventDisplay.paginate(page: params[:page], per_page: 50)
	end

	def target
		ed = EventDisplay.create(ed_params)
	end

	def ed_params
		params.permit(:outlet_id, :business_id, :token, :type)
	end

end
