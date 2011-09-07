require 'spec_helper'

describe WarsController do

  stub_user_moc_save
  login_user

  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template("wars/index")
    end
  end

  describe "#show and #edit" do
    before do
      Factory(:war)
      @wars = War.find(:first)
    end

    it "should render the show template" do
      get :show, :id => @wars
      response.should render_template("wars/show")
    end

    describe "edit action should render edit template" do
      it "should be successful" do
        get :edit, :id => @wars
        response.should render_template("wars/edit")
      end
    end
  end

  describe '#create' do
    before do
      post :create, :war => Factory.attributes_for(:war)
      @wars = War.find(:first)
      @response = response
    end

    it "should create a war" do
      War.all.size.should == 1
    end

    it "should redirect to that war" do
      @response.should redirect_to(@wars)
    end
  end

  describe '#update' do
    before do
      @wars = Factory(:war)
      put :update, :id => @wars.id, :war => { :war => "Badgers vs Pandas" }
    end

    it "should update the war name" do
      @wars.reload.war.should == "Badgers vs Pandas"
    end
  end

  describe '#destroy' do
    before do
      @wars = Factory(:war)
      @wars_count = War.all.size
      delete :destroy, :id => @wars.id
    end

    it "should destroy a wars" do
      War.all.size.should == @wars_count - 1
      expect{@wars.reload}.to raise_error ActiveRecord::RecordNotFound
    end

    it "should redirect to that wars_url" do
      @response.should redirect_to(wars_url)
    end
  end
end
