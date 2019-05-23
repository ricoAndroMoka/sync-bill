class StaticPagesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@ed = EventDisplay.paginate(page: params[:page], per_page: 50).order('created_at DESC')
	end

	def advance_ordering
		@ao = AdvanceOrdering.paginate(page: params[:page], per_page: 50).order('created_at DESC')
	end

	def target
		if params["event_type"] == "advance_ordering"
			target_advance_ordering
		else
			# ed = EventDisplay.create(ed_params)
			ed = EventDisplay.new
			ed.outlet_id = params[:outlet_id]
			ed.token = "since: #{params[:since]}, until: #{params[:until]}"
			ed.business_id = params[:business_id]
			ed.event_name = params[:event_name]
			ed.save
			# render nothing: true, status: 200
			render json: {message: 'success'}
		end
	end

	def return_error
		# raise 'Internal Server Error Test'
		output = {
      data: {},
      meta: {
        code: 500,
        error_message:  'custom error message',
        error_type: 'CustomErrorMessage'
      }
    }
    render json: output, status: :internal_server_error
	end

	def return_success
		if params[:delayed].present?
			sleep params[:delayed].to_i
		end

		respond_to do |format|
			format.html
			format.json {render json: {message: 'success with json'}}
		end
	end


	private

	def target_advance_ordering
		ao_params[:event_type] = 'advance ordering' if ao_params[:event_type].blank?
		ao = AdvanceOrdering.create(ao_params)

		token = params["token"]
		ao = AdvanceOrdering.new

		ao.event_name = params["event_name"]
		ao.outlet_id = params["outlet_id"]
		ao.application_order_id = params["application_order_id"]

		if token.present?
			ao.token = token["token"]
			ao.token_created_at = token["created_at"]
			ao.token_expired_at = token["expired_at"]
		end

		if ao.save
			render json: ao
		else
			render json: ao.errors
		end
	end

	def ed_params
		params.permit(:outlet_id, :business_id, :token, :event_name)
	end

	def ao_params
		params.permit(:outlet_id, :business_id, :event_name, :additional_data)
	end

end
