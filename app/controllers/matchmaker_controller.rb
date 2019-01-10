class MatchmakerController < ApplicationController
  def index
    @entries = User.all
  end
end
