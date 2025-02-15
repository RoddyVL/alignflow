class NichesController < ApplicationController
  before_action :set_project
  before_action :set_nich, only: %I[select show]

  def index
    @niches = @project.niches
  end

  def show
    @niches = @project.niches
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

    flash[:notice] = "Nous générons votre hypothèse de business..."

    GenerateContentJob.perform_later(@nich)

     redirect_to project_path(@nich.project)
  end

  def generate_ai_data
    @nich = @project.niches.first
    @project.niches.each do |nich|
      NichProblemGeneratorJob.perform_later(nich.id)
    end
    redirect_to project_nich_path(@project, @nich), notice: "Génération en cours..."
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
