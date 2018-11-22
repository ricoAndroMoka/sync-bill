class StaticPagesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@ed = EventDisplay.paginate(page: params[:page], per_page: 50).order('updated_at DESC')
	end

	def advance_ordering
		@ao = AdvanceOrdering.paginate(page: params[:page], per_page: 50).order('updated_at DESC')
	end

	def target
		if params["data"]["event_type"] == "a"
			target_advance_ordering
		else
			ed = EventDisplay.create(ed_params)
			render json: ed
		end
	end

	private

	def target_advance_ordering
		ao_params[:event_type] = 'advance ordering' if ao_params[:event_type].blank?
		ao = AdvanceOrdering.create(ao_params)

		data = params["data"]
		token = params["token"]
		ao = AdvanceOrdering.new

		ao.outlet_id = data["outlet_id"]
		ao.application_order_id = data["application_order_id"]
		ao.event_name = params["event_name"]
		ao.token = token["token"]
		ao.token_created_at = token["created_at"]
		ao.token_expired_at = token["expired_at"]

		if ao.save
			render json: ao
		else
			render json: ao.errors
		end
	end

	def ed_params
		params.permit(:outlet_id, :business_id, :token, :type)
	end

	def ao_params
		params.permit(:outlet_id, :business_id, :event_type, :additional_data)
	end

end
