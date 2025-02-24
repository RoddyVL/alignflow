class ScriptsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 2)
    @script = @nich.script
    @idea = @nich.ideas.find_by(status: 1)
    @category = @idea.categories.find_by(status: 1)
  end
end
