class Labeling < ActiveRecord::Base
   belongs_to :labelable, polymorphic: true
   belongs_to :label
   belongs_to :comment
 end
