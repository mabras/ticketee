require 'rails_helper'

RSpec.describe AttachmentPolicy do

  context 'permissions' do
    subject { AttachmentPolicy.new(user, attachment) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project) }
    let(:attachment) { FactoryGirl.create(:attachment, ticket: ticket) }

    context "for anounymouse users" do
      let(:user) { nil }
      it { should_not permit_action :show }
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }
      it { should permit_action :show }
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }
      it { should permit_action :show }
    end

    context "for the managers of the project" do
      before { assign_role!(user, :manager, project) }
      it { should permit_action :show }
    end

    context "for managers of the projects" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end
      it { should_not permit_action :show }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should permit_action :show }
    end
  end

  # let(:user) { User.new }

  # subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
