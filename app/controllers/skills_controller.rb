class SkillsController < ApplicationController
  before_action :set_project
  def new
    @skill = Skill.new
    @skills = Skill.where(project: @project)
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.project = @project
    if @skill.save
      redirect_to  new_project_skill_path(@project, @skill), notice: "compétence ajouter avec succès."
    else
      render :new
    end
  end

  def generate_ai_data
    @nich = @project.niches.first
    @project.niches.each do |nich|
      puts "start background job"
      NichProblemGeneratorJob.perform_later(nich.id)
    end
    redirect_to project_nich_path(@project, @nich)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
