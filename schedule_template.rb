class ReservationsController < ApplicationController
  before_action :ensure_logged_in
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservation = @restaurant.reservations.build
    @date_range = get_date_range
    @time_slot = get_time_slots
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    reservation = restaurant.reservations.build(reservation_params)
    reservation.user = current_user
    date_of_reservation = params[:date_of_reservation].to_date
    time_of_reservation = params[:time_of_reservation].to_time
    reservation.start_time = DateTime.new(date_of_reservation.year, date_of_reservation.month, date_of_reservation.day, time_of_reservation.hour, time_of_reservation.min)
    reservation.end_time = reservation.start_time + 1.hours
   
    if reservation.save
      redirect_to restaurant_path(reservation.restaurant)
    else
      @reservation = reservation
      @restaurant = restaurant
      @date_range = get_date_range
      @time_slot = get_time_slots
      render 'new'
    end

  end

  def edit
  end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    if params[:user_id]
      redirect_to user_reservations_path(params[:user_id])
    elsif params[:restaurant_id]
      redirect_to restaurant_reservations_path(params[:restaurant_id])
    end
  end

  def index
    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
      @reservations = @restaurant.get_current_week_reservations
      @reservations.each {|k,v|
        puts k
        v.each do |reservation|
          p reservation
        end
      }
      #@reservations = @restaurant.reservations.all
      @title = "Reservation List for restaurant #{@restaurant.name} in this week"

    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @reservations = @user.get_current_week_reservations
      @title = "Reservation List for user #{@user.name} in this week"
    end
  end

private
def reservation_params
  params.require(:reservation).permit(:start_time,:seats,:end_time,:restaurant_id)
end

def get_date_range
  (Date.today..2.week.from_now).inject([]){|arr,date| arr << [date.to_s, date]}
end

def get_time_slots
   time_slot = []
   seed = Time.new.change(:hour=> 11)
   for i in 1...10 do
     time_slot << [seed.strftime("%H:%M"),seed]
     seed += 3600
   end
   time_slot
end

end


# -------------------------------------------------------------------------------------------

<%= form_for [@restaurant, @reservation], html: {class: "form-horizontal"}  do |f| %>
  <% if @reservation.errors.any? %>
        <%= "#{pluralize(@reservation.errors.count,"error")} prohibit the reservation to be saved" %>
        <div class= "error_description">
            <ul>
              <% @reservation.errors.full_messages.each do |msg| %>
                <li><%= msg %></li>
              <% end %>
            </ul>
        </div>
  <% end %>
  <%= f.hidden_field :restaurant_id %>
      <div class="form-group">   
            <div class="col-sm-offset-2 col-sm-2">
                  <%= label_tag 'Date of Reservation:'  %>
                  <%= select_tag("date_of_reservation", options_for_select(@date_range,@date_range.size),{:class =>"form_control"})  %>
           </div>
      </div>
      <div class="form-group">   
            <div class="col-sm-offset-2 col-sm-2">
                  <%= label_tag 'Time of Reservation:'  %>
                  <%= select_tag("time_of_reservation", options_for_select(@time_slot,@time_slot.size), {:class =>"form_control"})  %>
              </div>
      </div>
      <div class="form-group">   
            <div class="col-sm-offset-2 col-sm-2">
                  <%= f.label :seats %>
                  <%= f.select :seats, (2..20), { :class => 'form_control' } %>
              </div>
      </div> 
      <div class="form-group">   
        <div class="col-sm-offset-2 col-sm-2">
              <%= f.submit :value => "Submit", :class=> "btn btn-lg btn-primary btn-block" %>
        </div>
      </div>
<% end %>