class ProjectsController < ApplicationController
  def index
    @niches = Nich.where(status: 2)
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    @nich = @project.niches.first
    @avatar = @nich.avatar
    @offer = @nich.offer
    @result = @nich.hypothesis_result
    @message = @nich.message
    @script = @nich.script
    @category = @nich.ideas.find_by(status: 1).categories.find_by(status: 1)
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user # Assurez-vous d'associer le projet à l'utilisateur courant

    if @project.valid?

      if @project.save
        redirect_to  new_project_nich_path(@project), notice: "Projet créée avec succès."
      else
        @projects = Project.all
        flash[:alert] = "Erreur lors de la création du projet."
        render :index
      end

    else
      flash[:alert] = "Veuillez remplir tous les champs obligatoires."
      render :index
    end
  end

  private

def project_params
  params.require(:project).permit(:name)
end
end
