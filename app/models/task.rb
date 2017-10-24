class Task < ApplicationRecord
  belongs_to :tasklist

  def completed?
    !completed_at.blank? #an task is completed if completed_at is NOT blank. (! means NOT.)
  end

end
