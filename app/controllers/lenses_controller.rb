class LensesController < ApplicationController
  before_action :set_lens, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  # GET /lenses
  # GET /lenses.json
  def index
    @lenses = Lens.all
  end

  # GET /lenses/1
  # GET /lenses/1.json
  def show
  end

  # GET /lenses/new
  def new
    @lens = Lens.new
  end

  # GET /lenses/1/edit
  def edit
  end

  # POST /lenses
  # POST /lenses.json
  def create
    @lens = Lens.new(lens_params)

    respond_to do |format|
      if @lens.save
        format.html { redirect_to @lens, notice: 'Lens was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lens }
      else
        format.html { render action: 'new' }
        format.json { render json: @lens.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lenses/1
  # PATCH/PUT /lenses/1.json
  def update
    respond_to do |format|
      if @lens.update(lens_params)
        format.html { redirect_to @lens, notice: 'Lens was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lens.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lenses/1
  # DELETE /lenses/1.json
  def destroy
    @lens.destroy
    respond_to do |format|
      format.html { redirect_to lenses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lens
      @lens = Lens.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lens_params
      params.require(:lens).permit(:name)
    end
end
