class PublicationsController < ApplicationController
  def create
    @publication = Publication.new(publication_params)
    @publication.user = current_user
    @publication.save
    redirect_to root_path
  end

  def publication_params
    params.require(:publication).permit(:message)
  end
end
