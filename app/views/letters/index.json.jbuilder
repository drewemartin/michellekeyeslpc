json.array!(@letters) do |letter|
  json.extract! letter, :id, :name, :email, :number, :message, :appointment
  json.url letter_url(letter, format: :json)
end
