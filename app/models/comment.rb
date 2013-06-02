class Comment < ActiveRecord::Base
  attr_accessible :body, :admin_id
  belongs_to :ticket
end
