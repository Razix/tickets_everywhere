class Comment < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :body, :admin_id
end
