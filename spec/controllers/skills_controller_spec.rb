require 'spec_helper'


describe SkillsController do
  login_user
  
  describe "#index" do
      it "should render the index template" do
        get :index
        response.should render_template("skills/index")
      end
   end

   describe "#show and #edit" do
     before do
       Factory(:skill)
       @skills = Skill.find(:first)
     end

     it "should render the show template" do
       get :show, :id => @skills
       response.should render_template("skills/show")
     end

     describe "edit action should render edit template" do
       it "should be successful" do
         get :edit, :id => @skills
         response.should render_template("skills/edit")
       end
     end
   end

   describe '#create' do
     before do
       post :create, :skill => Factory.attributes_for(:skill)
       @skills = Skill.find(:first)
       @response = response
     end

     it "should create a skill" do
       Skill.all.size.should == 1
     end

     it "should redirect to that skills" do
       @response.should redirect_to(@skills)
     end
   end

   describe '#update' do
     before do
       @skills = Factory(:skill)
       put :update, :id => @skills.id, :skill => { :skill => "Mechanic" }
     end

     it "should update the skill name" do
       @skills.reload.skill.should == "Mechanic"
     end
   end

   describe '#destroy' do
     before do
       @skills = Factory(:skill)
       @skills_count = Skill.all.size
       delete :destroy, :id => @skills.id
     end

     it "should destroy a skill" do
       Skill.all.size.should == @skills_count - 1
       expect{@skills.reload}.to raise_error ActiveRecord::RecordNotFound
     end

     it "should redirect to that skills_url" do
          @response.should redirect_to(skills_url)
     end
   end
  
end
