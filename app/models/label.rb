 class Label < ActiveRecord::Base
    has_many :labelings
 # #4
   has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
 # #5
   has_many :posts, through: :labelings, source: :labelable, source_type: :Post
 end