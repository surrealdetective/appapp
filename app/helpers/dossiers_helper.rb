module DossiersHelper

  # dossier_count_by_state(state):
  # used in layout nav to get those counts
  # usage:
  # dossier_count_by_state(:needs_review)
  #    #=> 35
  def dossier_count_by_state(state)
    Dossier.where(aasm_state: state).count
  end

end
