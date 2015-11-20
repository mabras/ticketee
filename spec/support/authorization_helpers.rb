module AuthorizationHelpers
  def assign_role!(user, role, project)
    Role.where(user: user, project: project)
    Role.create!(user: user, project: project)
  end
end


RSpec.configure do |c|
  c.include AuthorizationHelpers
end
