class NichesController < ApplicationController
  before_action :set_project
  before_action :set_nich, only: %i[show]
  # before_action :set_idea, only: %i[select]

  def index
    @niches = @project.niches
    
  end

  def show
    @niches = @project.niches
    @ideas = @nich.ideas
  end

  def new
    @nich = Nich.new
    @niches = Nich.where(project_id: @project)
  end

  def create
    @niche = Nich.new(nich_params)
    @niche.project = @project
    if @niche.save
      redirect_to  new_project_nich_path(@project, @niche), notice: "Niche ajouter avec succès."
    else
      render :new
    end
  end


  # Cette méthode est potentiellement inutile, à supprimer après vérification
  # def select
  #   @ideas = @nich.ideas
    # @idea.update(status: 1)
    # redirect_to project_nich_idea_categories_index_path(@project, @nich, @idea)
  # end

  def generate_ai_data
    @nich = @project.niches.first
    # @project.niches.each do |nich|
    #   puts "start background job"
    #   sleep 1
    #   NichProblemGeneratorJob.perform_later(nich.id)
    # end
    redirect_to project_nich_path(@project, @nich)
  end

  private

  def nich_params
    params.require(:nich).permit(:name)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_nich
    @nich = @project.niches.find(params[:id])
  end


  # def set_idea
  #   @idea = @nich.ideas.find(params[:id])
  # end
end
