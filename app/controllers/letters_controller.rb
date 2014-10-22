class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  # GET /letters/new
  def new
    @letter = Letter.new
  end


  # POST /letters
  # POST /letters.json
  def create
    @letter = Letter.new(letter_params)

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
        format.json { render :show, status: :created, location: @letter }
      else
        format.html { render :new }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end




private
  # Use callbacks to share common setup or constraints between actions.
  def set_letter
    @letter = Letter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def letter_params
    params.require(:letter).permit(:name, :email, :number, :message, :appointment)
  end

  def set_hours
     
  end
end
