module DossiersHelper

  def new_dossier_count
    Dossier.where(aasm_state: "new").count 
  end

  def needs_review_count
    Dossier.where(aasm_state: "needs_review").count
  end

  def needs_interview_count
    Dossier.where(aasm_state: "needs_interview").count
  end

  def needs_decision_count
    Dossier.where(aasm_state: "needs_decision").count
  end

end
