class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'Super Admin'
      can :manage, :all
    elsif user.role == "Admin"
      can :manage, :all
      cannot :manage, User
    end
  end
end