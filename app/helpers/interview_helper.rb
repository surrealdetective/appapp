module InterviewHelper
  
  # def interview_times(day)
  #   @hours = (day.midnight+9.hour)..(day.midnight+17.hour)  
  # end

  def start_time(day)
    day.midnight+9.hour
  end
  
end


