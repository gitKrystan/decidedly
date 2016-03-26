class MatricesChildrenController < CrudController
  before_action :set_matrix, only: [:new, :create, :edit, :update, :destroy]

  private

  def set_matrix
    @matrix = Matrix.find(params[:matrix_id])
  end
end
