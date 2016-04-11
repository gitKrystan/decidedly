class MatricesController < CrudController
  helper_method :options_sort_method, :options_sort_direction,
                :options_sort_criterium
  before_action :set_matrix, only: [:show, :edit, :update, :destroy]
  before_action :set_criteria, only: [:show, :edit, :update]
  before_action :set_options, only: [:show, :edit, :update]
  before_action :authenticate_matrix_owner, only: [:edit, :update, :destroy]

  def index
    @matrices = Matrix.order(created_at: :desc)
  end

  def show
  end

  def new
    @matrix = Matrix.new
  end

  def edit
  end

  def create
    @matrix = current_user.matrices.new(matrix_params)

    if @matrix.save
      flash[:notice] = "#{@matrix.name} was successfully created."
      redirect_to matrix_steps_path(@matrix)
    else
      render :new
    end
  end

  def update
    if @matrix.update(matrix_params)
      respond_to do |format|
        format.html do
          flash[:notice] = "#{@matrix.name} was successfully updated."
          redirect_to edit_matrix_path(@matrix)
        end
        format.js { get_attributes_for_jquery(matrix_params) }
      end
    else
      render :edit
    end
  end

  def destroy
    @matrix.destroy
    redirect_to matrices_path,
                notice: "#{@matrix.name} was successfully deleted."
  end

  private

  def matrix_params
    score_attributes = [:id, :amount, :criterium_id, :option_id, :bin_id]
    option_attributes = [:id, :name, scores_attributes: score_attributes]
    params.require(:matrix).permit(:name, options_attributes: option_attributes)
  end

  def set_matrix
    @matrix = Matrix.find(params[:id])
  end

  def set_criteria
    @criteria = @matrix.criteria.order(:name) # TODO: order by user sequence
  end

  def set_options
    @options = @matrix.options_by(options_sort_method,
                                  options_sort_direction,
                                  options_sort_criterium)
  end

  def options_sort_method
    params[:sort_options_by] || 'name'
  end

  def options_sort_direction
    params[:options_direction] || 'asc'
  end

  def options_sort_criterium
    params[:sort_by_criterium] || nil
  end

  def criteria_count
    @matrix.criteria.count
  end
  helper_method :criteria_count

  def get_attributes_for_jquery(matrix_params)
    options_attributes = matrix_params[:options_attributes]['0']
    scores_attributes = options_attributes[:scores_attributes]['0']
    @option_id = options_attributes[:id].to_i
    @criterium_id = scores_attributes[:criterium_id].to_i
    @bin_id = scores_attributes[:bin_id].to_i
  end
end
