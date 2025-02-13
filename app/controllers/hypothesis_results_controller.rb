class HypothesisResultsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1)
    @hypothesis = @nich.hypothesis_result
    @results = HypothesisResult.all
  end
end
