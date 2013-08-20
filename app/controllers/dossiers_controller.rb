class DossiersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]

  # dossiers#new
  # GET new_dossier_path
  def new
    @user = User.new
    @dossier = Dossier.new
    @course = @dossier.build_course()
    @course_list = Course.list_for_selectbox
    @title = "New Dossier"
  end


  # dossiers#create
  # POST dossiers_path
  def create
    # if current_user
      #user = current_user
    # else
      @user = User.new(params[:user])
      @user.password = rand(36**12).to_s(36)
      @user.set_role(:applicant)
      # move this mailer to assm after_enter new
      UserMailer.welcome_email(@user).deliver
    # end
    @dossier = @user.dossiers.build(params[:dossier])
    @dossier.save
    if @user.save_with_dossier_status("submitted")
      session[:user_id] = @user.id
      redirect_to @dossier
    else
      #raise
     # @user= User.find(params[:user_id])
     @course = @dossier.build_course()

    @course_list = Course.list_for_selectbox
 
      render new_dossier_path
    end
  end

  # dossiers#index
  # GET dossiers_path
  def index
    @title = "Dossier Index"
    @statuses = Dossier.aasm.states.collect(&:to_s)

    @dossiers = Dossier
    @dossiers = @dossiers.with_user_name(params[:name])  if params[:name].present?
    @dossiers = @dossiers.with_hashtag(params[:hashtag]) if params[:hashtag].present?
    @dossiers = @dossiers.with_status(params[:status])   if params[:status].present?
    @dossiers = @dossiers.sort_by(params[:sort_by])      if params[:sort_by].present?
    @dossiers = @dossiers.includes(:user, :dossier_statuses).all
    authorize! :index, @dossiers
    # render :json =>  @dossiers
  end
  
  def show

    @dossier = Dossier.find(params[:id])
    authorize! :read, @dossier
    @body_classes = "dossier-form-bg"
    @user = @dossier.user
    @codeschool = HTTParty.get(@dossier.codeschool_link)
    @treehouse  = HTTParty.get(@dossier.treehouse_link)
    email_address = @user.email.downcase
    @avatar_hash = Digest::MD5.hexdigest(email_address)
    @title = "#{@user.full_name}'s Dossier"
    respond_to do |format|
      if params[:layout] == "false"
        format.html {render :layout => 'simple'}
      else
        format.html
      end
    end
  end

  def edit
    # show the edit form
    
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    @course = @dossier.course
    @course_list = Course.list_for_selectbox
    @title = "Edit #{@user.full_name}'s Dossier"
    email_address = @user.email.downcase
    @avatar_hash = Digest::MD5.hexdigest(email_address)
  end

  def update
    # PUT the new information
    @dossier = Dossier.find(params[:id])
    @user = @dossier.user
    @dossier.update_attributes(params[:dossier])
    @user.update_attributes(params[:user])
    redirect_to @dossier
  end

  def transition
    @dossier = Dossier.find(params[:id])
    if Dossier.aasm.events.keys.map(&:to_s).include? params[:transition]
      authorize! :manage, @dossier
      @dossier.send(params[:transition])
      redirect_to :back
    else
      render :json => {}, :status => 400 # bad request
    end
  end

  def admin_act
    @dossier = Dossier.find(params[:id])
    respond_to do |format|
      if params[:layout] == "false"
        format.html {render :layout => 'simple'}
      else
        format.html
      end
    end
  end

  def hashtags
    @dossier = Dossier.find(params[:id])
  end
    
end
