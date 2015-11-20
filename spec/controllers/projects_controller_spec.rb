require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it "handles a missing project properly" do
    get :show, id: "soso"

    expect(response).to redirect_to(projects_path)

    expect(flash[:alert]).to eq "The project you were looking for could not be found."
  end

  it "handles permision errors by redirecting to a save place" do
    allow(controller).to receive(:current_user)

    project = FactoryGirl.create :project
    get :show, id: project

    expect(response).to redirect_to(root_path)
    message = "You aren't allowed to do that."
    expect(flash[:alert]).to eq message

  end

end
