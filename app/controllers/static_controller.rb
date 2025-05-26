class StaticController < ApplicationController
  def index
    @puny_human = PunyHuman.new
  end
end
