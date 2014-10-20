require 'rails_helper'

RSpec.describe "letters/show", :type => :view do
  before(:each) do
    @letter = assign(:letter, Letter.create!(
      :name => "Name",
      :email => "Email",
      :number => "Number",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Number/)
    expect(rendered).to match(/MyText/)
  end
end
