class StaticPagesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@ed = EventDisplay.paginate(page: params[:page], per_page: 50).order('updated_at DESC')
	end

	def advance_ordering
		@ao = AdvanceOrdering.paginate(page: params[:page], per_page: 50).order('updated_at DESC')
	end

	def target
		ed = EventDisplay.create(ed_params)
		render inline: 'success'
	end

	def target_advance_ordering
		ao_params[:event_type] = 'advance ordering' if ao_params[:event_type].blank?
		ao = AdvanceOrdering.create(ao_params)
		render inline: 'success'
	end

	private

	def ed_params
		params.permit(:outlet_id, :business_id, :token, :type)
	end

	def ao_params
		params.permit(:outlet_id, :business_id, :event_type, :additional_data)
	end

end
