class NeedsInterviewController < ApplicationController
  def index
    @dossiers = Dossier.where("aasm_state like ?", "%interview%")
    authorize! :index, @dossiers
  end
end