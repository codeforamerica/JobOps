require 'spec_helper'

describe EducationsController do

  login_user
 
  before(:each) do
    @user = Factory(:user)
  end
 
  describe "#index" do
     it "should render the index template" do
       get :index
       response.should render_template("educations/index")
     end
  end
  
  describe "#show and #edit" do
    before do
      Factory(:education)
      @educations = Education.find(:first)
    end
    
    it "should render the show template" do
      get :show, :id => @educations
      response.should render_template("educations/show")
    end
    
    describe "edit action should render edit template" do
      it "should be successful" do
        get :edit, :id => @educations
        response.should render_template("educations/edit")
      end
    end
  end
  
  describe '#create' do
    before do
      post :create, :education => Factory.attributes_for(:education)
      @educations = Education.find(:first)
      @response = response
    end
    
    it "should create a job" do
      Education.all.size.should == 1
    end
    
    it "should redirect to that job" do
      @response.should redirect_to(@educations)
    end
  end
  
  describe '#update' do
    before do
      @educations = Factory(:education)
      put :update, :id => @educations.id, :education => { :school_name => "Civic Commons" }
    end

    it "should update the school name" do
      @educations.reload.school_name.should == "Civic Commons"
    end
  end
  
  describe '#destroy' do
    before do
      @educations = Factory(:education)
      @educations_count = Education.all.size
      delete :destroy, :id => @educations.id
    end

    it "should destroy a education" do
      Education.all.size.should == @educations_count - 1
      expect{@educations.reload}.to raise_error ActiveRecord::RecordNotFound
    end
    
    it "should redirect to that educations_url" do
         @response.should redirect_to(educations_url)
    end
  end  
end
