class BmesseagesController < ApplicationController
  before_action :set_bmesseage, only: %i[ show edit update destroy ]

  # GET /bmesseages or /bmesseages.json
  def index
    @bmesseages = Bmesseage.all
  end

  # GET /bmesseages/1 or /bmesseages/1.json
  def show
  end

  # GET /bmesseages/new
  def new
    @bmesseage = Bmesseage.new
  end

  # GET /bmesseages/1/edit
  def edit
  end

  # POST /bmesseages or /bmesseages.json
  def create
    @bmesseage = Bmesseage.new(bmesseage_params)

    respond_to do |format|
      if @bmesseage.savelesson
        format.turbo_stream { render turbo_stream: turbo_stream.prepend( "messageing" , partial: "bmesseages/messages", locals: {
          bmesseage: @bmesseage 
          })}
        format.html { redirect_to bmesseage_url(@bmesseage), notice: "Bmesseage was successfully created." }
        format.json { render :show, status: :created, location: @bmesseage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bmesseage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmesseages/1 or /bmesseages/1.json
  def update
    respond_to do |format|
      if @bmesseage.update(bmesseage_params)
        format.html { redirect_to bmesseage_url(@bmesseage), notice: "Bmesseage was successfully updated." }
        format.json { render :show, status: :ok, location: @bmesseage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bmesseage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmesseages/1 or /bmesseages/1.json
  def destroy
    @bmesseage.destroy

    respond_to do |format|
      format.html { redirect_to bmesseages_url, notice: "Bmesseage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmesseage
      @bmesseage = Bmesseage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bmesseage_params
      params.require(:bmesseage).permit(:body)
    end
end
