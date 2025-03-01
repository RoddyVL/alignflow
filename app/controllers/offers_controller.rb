class OffersController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1) || @project.niches.find_by(status: 2)
    @offer = @nich.offer
    @category = @nich.ideas.find_by(status: 1).categories.find_by(status: 1)
  end
end
