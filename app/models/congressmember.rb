require_relative '../../db/config'

class CongressMember < ActiveRecord::Base

  def name
    name = "#{self[:firstname]} #{self[:middlename]} #{self[:namesuffix]}}"
  end

end