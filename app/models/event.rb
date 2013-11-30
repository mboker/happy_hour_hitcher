class Event < ActiveRecord::Base
    validates :day,
        :inclusion => { :in => [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' ]}
end
