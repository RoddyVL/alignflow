class ScriptsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1)
    @script = @nich.script
  end
end
