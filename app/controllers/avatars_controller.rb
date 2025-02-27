class AvatarsController < ApplicationController
  before_action :set_browser
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1) || @project.niches.find_by(status: 2)
    @avatar = @nich.avatar
    # @category = @nich.ideas.find_by(status: 2).categories.find_by(status: 1)
  end

  private

  def set_browser
    @browser = Browser.new(request.user_agent)
  end
end
