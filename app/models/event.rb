class Event < ActiveRecord::Base
    validates :day,
        :inclusion => { :in => [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' ]}
    belongs_to :location
end
