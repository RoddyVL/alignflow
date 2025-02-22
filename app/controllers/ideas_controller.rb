class IdeasController < ApplicationController
  before_action :set_project
  before_action :set_nich
  before_action :set_idea, only: [:select_idea]

  def select_idea
    @idea.update(status: 1)
    @idea.nich.update(status: 2)
      GenerateCategoriesJob.perform_later(@idea)
      redirect_to project_nich_idea_category_index_path(@project, @nich, @idea)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_nich
    @nich = @project.niches.find(params[:nich_id])
  end

  def set_idea
    @idea = @nich.ideas.find(params[:id])
  end
end
