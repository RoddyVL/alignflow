class AvatarsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1)
    @avatar = @nich.avatar
  end
end
