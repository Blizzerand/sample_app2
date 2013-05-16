# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#


require 'spec_helper'

describe User do 

	before { @user = User.new(name: "Example User", email: "exampleuser@example.org", password: "icanrock", password_confirmation: "icanrock") }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a"*51 }
		it { should_not be_valid }

	end

	describe "when name is too short" do
		before { @user.name = "a"*3 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should not be valid" do
			address = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]

       		address.each do |invalid_address|
       			@user.email = invalid_address
       			@user.should_not be_valid 
       		end
       	end
    end	

     describe "when email format is valid" do	
     	it "should be valid" do
     		address = %w[user@example.com user.new@example.com NEW_user@gmail.COM 
     				  me+myfriends@techampere.co.uk trade-Raider@wiki.co.jp]

     		address.each do |valid_address|
     			@user.email = valid_address
     			@user.should be_valid
     		end
     	end
    end

    describe "email address is already taken" do
    	before do
    		user_dup = @user.dup
    		user_dup.email.upcase!
    		user_dup.save
    	end

    	it { should_not be_valid }
    end

    describe "the password should not be too small" do
        before { @user.password = @user.password_confirmation = "a*5" }
        it { should_not be_valid}
    end

    describe "when the password is not present" do
        before { @user.password = @user.password_confirmation = " " }
        it { should_not be_valid }
    end	

    describe "when the password_confirmation does not match" do
        before { @user.password_confirmation = "helloworld" }
        it { should_not be_valid }
    end 

    describe "when the password_confirmation is nil" do
        before { @user.password_confirmation = nil }
        it { should_not be_valid }
    end

    describe "return value of authentication method" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) }

        describe "if authentication is valid" do
            it { should == found_user.authenticate(@user.password) }
        end

        describe "if authentication is invalid" do
            let(:user_invalid) { found_user.authenticate("invalidpassword") }
            it { should_not == user_invalid }
            specify { user_invalid.should be_false }
        end
    end
end
