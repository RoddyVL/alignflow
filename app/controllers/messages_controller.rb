class MessagesController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @nich = @project.niches.find_by(status: 1)
    @message = @nich.message
    @messages = Message.all
  end
end
