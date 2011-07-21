require 'spec_helper'

describe CertificationsController do
  
  login_user
  
  describe "#index" do
    it "should render the index template" do
      get :index
        response.should render_template("certifications/index")
      end
    end
    
    describe "#show and #edit" do
      before do
        Factory(:certification)
        @certs = Certification.find(:first)
      end
      
      it "should render the show template" do
        get :show, :id => @certs
        response.should render_template("certifications/show")
      end
      
      describe "edit action should render edit template" do
        it "should be successful" do
          get :edit, :id => @certs
          response.should render_template("certifications/edit")
        end
      end
  end

  describe '#create' do
    before do
      post :create, :certifications => Factory.attributes_for(:certification)
      @certs = Certification.find(:first)
      @response = response
    end
       
    it "should create a Certification" do
      Certification.all.size.should == 1
    end

    it "should redirect to that certifications" do
      @response.should redirect_to(@certs)
    end
  end
  
  describe '#update' do
    before do
      @certs = Factory(:certification)
      put :update, :id => @certs.id, :certification => { :name => "Ruby on Rails" }
    end
    
    it "should update the skill name" do
      @certs.reload.name.should == "Ruby on Rails"
    end
  end
  
  describe '#destroy' do
    before do
      @certs = Factory(:certification)
      @certs_count = Certification.all.size
      delete :destroy, :id => @certs.id
    end
    
    it "should destroy a certification" do
      Certification.all.size.should == @certs_count - 1
        expect{@certs.reload}.to raise_error ActiveRecord::RecordNotFound
    end
    
    it "should redirect to that skills_url" do
      @certs.should redirect_to(certifications_url)
    end
  end
end