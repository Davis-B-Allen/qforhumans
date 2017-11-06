class CelebritiesController < ApplicationController
  def random
    @celebrities = Celebrity.all
  end
end
