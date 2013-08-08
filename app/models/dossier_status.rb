class DossierStatus < ActiveRecord::Base
  attr_accessible :status, :dossier_id
  belongs_to :dossier
  has_one :course, :through => :dossier
  
  def self.list
    Dossier.aasm.states
  end

  def avg_time
    similar_statuses = DossierStatus.joins(:course)
                              .where(:status => self.status, "courses.id" => self.course.id)
                              .includes(:dossier => :dossier_statuses)
    total = 0
    count = 0
    similar_statuses.each do |status|
      status_siblings = status.dossier.dossier_statuses
      index = status_siblings.index(status)
      next_status = status_siblings[index + 1]
      if next_status
        count += 1
        total += next_status.created_at - status.created_at
      end
    end

    count = 1 if count.zero?
    total / count
  end

end
