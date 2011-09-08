require 'spec_helper'

describe AwardsController do
  stub_user_moc_save
  login_user

  describe "#index" do
      it "should render the index template" do
        get :index
        response.should render_template("awards/index")
      end
   end

   describe "#show and #edit" do
     before do
       Factory(:award)
       @awards = Award.find(:first)
     end

     it "should render the show template" do
       get :show, :id => @awards
       response.should render_template("awards/show")
     end

     describe "edit action should render edit template" do
       it "should be successful" do
         get :edit, :id => @awards
         response.should render_template("awards/edit")
       end
     end
   end

   describe '#create' do
     before do
       post :create, :award => Factory.attributes_for(:award)
       @awards = Award.find(:first)
       @response = response
     end

     it "should create an award" do
       Award.all.size.should == 1
     end

     it "should redirect to that award" do
       @response.should redirect_to(@awards)
     end
   end

   describe '#update' do
     before do
       @awards = Factory(:award)
       put :update, :id => @awards.id, :award => { :award => "Mushroom Star" }
     end

     it "should update the award name" do
       @awards.reload.award.should == "Mushroom Star"
     end
   end

   describe '#destroy' do
     before do
       @awards = Factory(:award)
       @awards_count = Award.all.size
       delete :destroy, :id => @awards.id
     end

     it "should destroy an award" do
       Award.all.size.should == @awards_count - 1
       expect{@awards.reload}.to raise_error ActiveRecord::RecordNotFound
     end

     it "should redirect to that awards_url" do
          @response.should redirect_to(awards_url)
     end
   end
end
