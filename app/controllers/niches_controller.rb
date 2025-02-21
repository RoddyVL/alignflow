class NichesController < ApplicationController
  before_action :set_project
  before_action :set_nich, only: %I[select show]

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


  def select
    @nich.update(status: Nich::SELECTED)

    GenerateContentJob.perform_later(@nich.id)
    sleep 1 # Test pour voir si l'avatar a eu le temps d'être créé
    redirect_to project_nich_avatar_path(@project, @nich, @nich.avatar)
  end

  def generate_ai_data
    @nich = @project.niches.first
    @project.niches.each do |nich|
      puts "start background job"
      NichProblemGeneratorJob.perform_later(nich.id)
    end
    sleep 1
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
    @nich = Nich.find(params[:id])
  end
end
