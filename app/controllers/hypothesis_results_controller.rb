class HypothesisResultsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 2)
    @result = @nich.hypothesis_result
    @results = HypothesisResult.all
  end
end
