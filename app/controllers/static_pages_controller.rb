class StaticPagesController < ApplicationController

	def index
		@ed = EventDisplay.all
	end

	def target
		ed = EventDisplay.create(params[:data])
		render nothing: true
	end
end
