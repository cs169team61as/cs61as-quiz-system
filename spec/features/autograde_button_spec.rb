require 'spec_helper'

describe "Autograde button" do 
	let(:staff) { create :reader }
	before do
    	sign_in staff
    	visit staffs_grades_path
  	end
end