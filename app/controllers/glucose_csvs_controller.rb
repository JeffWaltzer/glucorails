class GlucoseCsvsController < ApplicationController
  before_action :set_glucose_csv, only: %i[ show edit update destroy ]

  # GET /glucose_csvs or /glucose_csvs.json
  def index
    @glucose_csvs = GlucoseCsv.all
  end

  # GET /glucose_csvs/1 or /glucose_csvs/1.json
  def show
  end

  # GET /glucose_csvs/new
  def new
    @glucose_csv = GlucoseCsv.new
  end

  # GET /glucose_csvs/1/edit
  def edit
  end

  # POST /glucose_csvs or /glucose_csvs.json
  def create
    csv= create_params[:csv].read
    @glucose_csv = GlucoseCsv.new
    CsvParser.new(csv).build_measurements

    respond_to do |format|
      if @glucose_csv.save
        format.html { redirect_to @glucose_csv, notice: "Glucose csv was successfully created." }
        format.json { render :show, status: :created, location: @glucose_csv }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @glucose_csv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /glucose_csvs/1 or /glucose_csvs/1.json
  def update
    respond_to do |format|
      if @glucose_csv.update(create_params)
        format.html { redirect_to @glucose_csv, notice: "Glucose csv was successfully updated." }
        format.json { render :show, status: :ok, location: @glucose_csv }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @glucose_csv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /glucose_csvs/1 or /glucose_csvs/1.json
  def destroy
    @glucose_csv.destroy!

    respond_to do |format|
      format.html { redirect_to glucose_csvs_path, status: :see_other, notice: "Glucose csv was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glucose_csv
      @glucose_csv = GlucoseCsv.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def create_params
      params.require(:glucose_csv).permit(:csv)
    end
end
