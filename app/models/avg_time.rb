class AvgTime < ActiveRecord::Base
  attr_accessible :avg_time_in, :count, :course_id, :status

  belongs_to :course

  def self.update(dossier)
    status = dossier.dossier_statuses.last
    status_duration = Time.now - status.created_at
    AvgTime.find_by_status_and_course_id(status.status, dossier.course_id)
  end
end
