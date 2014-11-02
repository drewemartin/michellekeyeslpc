class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  # GET /letters/new
  def new
    @letter = Letter.new
    @year_range = years
    @month_range = months
    @day_range = days
    @time_range = times
  end


  # POST /letters
  # POST /letters.json
  def create
    @letter = Letter.new(letter_params)
    unless params[:month] == '' || params[:day] == '' 
      @letter.appointment = DateTime.new(set_appointment_year(params[:year],params[:month]), params[:month].to_i, set_appointment_day(params[:month],params[:day],params[:year]), set_appointment_time(params[:time]))
    end
    


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
    params.require(:letter).permit(:name, :email, :number, :message, :appointment, :month)
  end

  def years
    x = 0
    base_year = Time.zone.now.year
    year_range = [nil]
    
    while x < 3 do
      year_range << (base_year + x)
      x+=1
      puts year_range
    end

    return year_range

  end

  def months
    x = 1
    month_range = [nil]
    
    while x < 13 do
      month_range << x
      x+=1
      puts month_range
    end

    return month_range
     
  end

  def days
    x = 1
    day_range = [nil]
    
    while x < 32 do
      day_range << x
      x+=1
      puts day_range
    end

    return day_range
    
  end

  def times
    x = 9
    time_range = [nil]

    while x < 18 do
      if x < 12
        time_range << "#{x} am"
        x+=1
      elsif x == 12
        time_range << "#{x} pm"
        x+=1
      else
        time_range << "#{x - 12} pm"
        x+=1
      end
    end

    return time_range

  end

  def set_appointment_day(month,day,year) 
    month = month.to_i
    day = day.to_i
    year = year.to_i
    if day > 28
      case month
      when 2
        if year % 4 == 0 
          return 29
        else
          return 28
        end
      when 4,6,9,11
        if day > 30
          return 30
        else
          return day
        end
      else
        return day
      end
    else
      return day
    end

  end

  def set_appointment_time(time)
    if time.nil?
      return 0
    elsif time.split(' ').include? 'pm'
      integer_val = time.delete!(' ').delete!('pm').to_i
      if integer_val < 11
        return integer_val + 12
      else
        return integer_val
      end
    elsif time.split(' ').include? 'am'
      return time.delete!(' ').delete!('am').to_i
    end
  end

  def set_appointment_year(year,month)
    current_year = Time.now.year
    current_month = Time.now.month
    if year.nil? && month < current_month
      return (current_year + 1)
    elsif year.nil?
      return current_year
    else
      return year.to_i
    end
  end

end
