class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Blocpedia #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis.visible_to(current_user)
    @private_wikis = @wikis.where(private: true)
    @public_wikis = @wikis.where(private: false)
  end

  def downgrade
    @wikis = current_user.wikis
    @user = User.find(params[:id])
    @user.update_attribute(:premium, false)
    @wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    redirect_to user_registration_path
  end
end
