class WikisController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!

  after_action :verify_authorized, :except => :index

  #before_action :require_sign_in, except: :show
  #before_action :authorize_user, except: :show

  def index
    #@wikis = Wiki.all
    @wikis = policy_scope(Wiki)#.paginate(page: params[:page], per_page: 10)
    #authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    #@wiki.title = params[:post][:title]
    #@wiki.body = params[:post][:body]

    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    #@wiki.title = params[:post][:title]
    #@wiki.body = params[:post][:body]
    authorize @wiki

    @wiki.assign_attributes(wiki_params)
    @wiki.user_ids = params[:wiki][:user_ids] if params[:wiki][:user_ids].present?

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user, :user_ids)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end
end
