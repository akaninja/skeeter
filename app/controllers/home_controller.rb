class HomeController < ApplicationController
  def index
    @publication = Publication.new
    @publications = (Publication.where(user: current_user.followings)
                    .or(Publication.where(user: current_user)))
                    .last(5).reverse
  end
end
