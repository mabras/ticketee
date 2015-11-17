require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  it "handles a missing project properly" do
    get :show, id: "soso"

    expect(response).to redirect_to(projects_path)

    expect(flash[:alert]).to eq "The project you were looking for could not be found."
  end

end
