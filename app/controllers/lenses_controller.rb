class LensesController < ApplicationController
  before_action :set_len, only: [:show, :edit, :update, :destroy]

  # GET /lens
  # GET /lens.json
  def index
    @lens = Len.all
  end

  # GET /lens/1
  # GET /lens/1.json
  def show
  end

  # GET /lens/new
  def new
    @len = Len.new
  end

  # GET /lens/1/edit
  def edit
  end

  # POST /lens
  # POST /lens.json
  def create
    @len = Len.new(len_params)

    respond_to do |format|
      if @len.save
        format.html { redirect_to @len, notice: 'Len was successfully created.' }
        format.json { render action: 'show', status: :created, location: @len }
      else
        format.html { render action: 'new' }
        format.json { render json: @len.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lens/1
  # PATCH/PUT /lens/1.json
  def update
    respond_to do |format|
      if @len.update(len_params)
        format.html { redirect_to @len, notice: 'Len was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @len.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lens/1
  # DELETE /lens/1.json
  def destroy
    @len.destroy
    respond_to do |format|
      format.html { redirect_to lens_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_len
      @len = Len.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def len_params
      params.require(:len).permit(:name)
    end
end
