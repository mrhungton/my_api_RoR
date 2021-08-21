class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    send("#{user.role}_abilities", user)
  end

  def admin_abilities(current_user)
    ##### USER #####
    # Admin can list all users
    can :list, User

    # Admin can get detail of all users
    can :show, User

    # Admin can add users
    can :create, User

    # Admin can edit users
    can :update, User

    # Admin users can delete non-admin users
    can :destroy, User, {role: 'user'}
    cannot :destroy, User, {role: 'admin'}

    # Admin can block non-admin users
    can :block, User, {role: 'user'}
    cannot :block, User, {role: 'admin'}

    # Admin can unblock non-admin users // BUNUS
    can :unblock, User, {role: 'user'}
    can :unblock, User, {role: 'admin'}

    ##### BLOG #####
    # Users can list all blogs
    can :list, Blog

    # Users can view a blog
    can :show, Blog
    
    # Users should be able to create a blog
    can :create, Blog

    # Only the creator or admin can update blog
    can :update, Blog, {user_id: current_user.id}

    # Only the creator or admin can delete blog
    can :update, Blog, {user_id: current_user.id} # current_user is the creator
    can :update, Blog, {user_id: !current_user.id} # current_user is not the creator

    # Admin can unpublish blogs
    can :unpublish, Blog
    can :publish, Blog
  end

  def user_abilities(current_user)
    ##### USER #####
    # Admin can list all users (non-block)
    can :list, User
    can :list_not_blocked, User

    #x Can get detail of a non-block user
    can :show, User, {blocked_at: nil}
    
    ##### BLOG #####
    # Users can list all blogs (only published)
    can :list, Blog
    can :list_published, Blog

    # Users can view a blog
    can :show, Blog

    # Users should be able to create a blog
    can :create, Blog

    # Only the creator or admin can update blog
    can :update, Blog, {user_id: current_user.id} # current_user is the creator
    cannot :update, Blog, {user_id: !current_user.id} # current_user is not the creator

    # Users can unpublished their blog
    can :unpublish, Blog, {user_id: current_user.id}
    can :publish, Blog, {user_id: current_user.id}
  end

  # Get rules list
  def to_list
    rules.map do |rule|
      object = { action: rule.actions, subject: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name } }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
