class NichesController < ApplicationController
  before_action :set_project, only: [:new, :create, :index, :show]
  before_action :set_nich, only: [:select, :show]

  def index
    @niches = @project.niches
  end

  def show
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
