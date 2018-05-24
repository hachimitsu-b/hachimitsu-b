class Admins::RecommendsController < ApplicationController
  def index
  	@type_new = TypeName.new
  	@type_names = TypeName.all
  	@recommend = Recommend.new
  	@cds = Cd.last(5)
  end
end
