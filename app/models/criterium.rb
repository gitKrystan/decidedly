class Criterium < ActiveRecord::Base
  belongs_to :matrix
  # matrix(force_reload = false)
  # matrix=(associate)
  # build_matrix(attributes = {})
  # create_matrix(attributes = {})
  # create_matrix!(attributes = {})
  validates :matrix, presence: true

  validates :name, presence: true
end
