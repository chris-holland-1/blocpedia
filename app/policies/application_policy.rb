class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  #class WikiPolicy
  #attr_reader :user, :wiki

    #def initialize(user, wiki)
      #@user = user
      #@wiki = wiki
    #end

    #def update?
      #user.admin? or not wiki.published?
    #end
  #end

  #class Scope
    #attr_reader :user, :scope

    #def initialize(user, scope)
      #@user = user
      #@scope = scope
    #end

    #def resolve
      #wikis = []
      #if user.present?
        #if user.admin?
        #wikis = scope.all
      #elsif user.premium?
        #all_wikis = scope.all
        #all_wikis.each do |wiki|
          #if wiki.public? || wiki.user == user || wiki.users.include?(user)
            #wikis << wiki
          #end
        #end
      #else
        #all_wikis = scope.all
        #wikis = []
        #all_wikis.each do |wiki|
          #if wiki.public? || wiki.users.include?(user)
            #wikis << wiki
          #end
        #end
      #end
    #end
      #wikis
    #end
  #end
end
