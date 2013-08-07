class AvgTime < ActiveRecord::Base
  attr_accessible :avg_time_in, :count, :course_id, :status

  belongs_to :course

  def self.update(dossier)
    status = dossier.dossier_statuses.last
    status_duration = Time.now - status.created_at
    avg_status_duration = AvgTime.find_or_create_by_status_and_course_id(status.status, dossier.course_id)
    count = avg_status_duration.count || 0
    avg_time = avg_status_duration.avg_time_in || 0
    avg_status_duration.avg_time_in = ((avg_time * count) + status_duration)/(count + 1)
    avg_status_duration.count = count + 1
    avg_status_duration.save
  end
end
