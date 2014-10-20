require 'rails_helper'

RSpec.describe "letters/edit", :type => :view do
  before(:each) do
    @letter = assign(:letter, Letter.create!(
      :name => "MyString",
      :email => "MyString",
      :number => "MyString",
      :message => "MyText"
    ))
  end

  it "renders the edit letter form" do
    render

    assert_select "form[action=?][method=?]", letter_path(@letter), "post" do

      assert_select "input#letter_name[name=?]", "letter[name]"

      assert_select "input#letter_email[name=?]", "letter[email]"

      assert_select "input#letter_number[name=?]", "letter[number]"

      assert_select "textarea#letter_message[name=?]", "letter[message]"
    end
  end
end
