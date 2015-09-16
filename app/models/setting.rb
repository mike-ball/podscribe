class Setting < ActiveRecord::Base
  belongs_to :user
  belongs_to :podcast
  belongs_to :episode
end
