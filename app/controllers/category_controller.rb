class CategoryController < ApplicationController
  before_action :set_project
  before_action :set_nich
  before_action :set_idea

  def index
    @categories = @idea.categories
  end

  def select_category
    @category.update(status: 1)
    GenerateCategoriesJob.perform_later(@category)
    redirect_to project_path(@project), notice: "Idée sélectionnée avec succès." 
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_nich
    @nich = @project.niches.find(params[:nich_id])
  end

  def set_idea
    @idea = @nich.ideas.find(params[:idea_id])
  end

  def select_category
    @category = @idea.categories.find(params[:category_id])
  end
end
