require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit root_path
      page.should have_selector('h1', :text =>'Sample App')
    end
    it "should have the base title" do
    	visit root_path
    	page.should have_selector('title', :text => "Ruby on Rails Sample App")
    end
	  it "should not have a custom page title" do
	  	visit root_path
	  	page.should_not have_selector('title', :text=> "| Home")
	  end
	end
    
  describe "Help Page" do
  	
  	it "should have the content 'Help Page'" do
  		visit help_path
  		page.should have_selector('h1', :text=> 'Help')
  	end
  	it "should have the title 'Help'" do
  		visit help_path
      page.should have_selector('title', :text => "Ruby on Rails Sample App | Help")
  	end
  end
  
  describe "About Us Page"  do
  	
  	it "should have the content 'About Us'" do
  		visit about_path
  		page.should have_selector('h1', :text=>'About Us')
  	end
  	it "should have the title 'About Us'" do
  		visit about_path
  		page.should have_selector('title', :text => "Ruby on Rails Sample App | About Us")
    end 
  end
  
  describe "Contact Us Page" do
  	
  	it "should have content 'Contact Us'" do
  		visit contact_path
  		page.should have_selector('h1', :text => 'Contact Us')
  	end
	 
	 it "should have the title 'Contact Us'" do
	 		visit contact_path
	 		page.should have_selector('title', :text => 'Ruby on Rails Sample App | Contact Us')
	 		end 
  	end
end
