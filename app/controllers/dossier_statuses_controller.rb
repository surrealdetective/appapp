class DossierStatusesController < ApplicationController
  def new

    @dossier = Dossier.find(params[:dossier_id])
    @user = @dossier.user



    # @user = User.find_by_id(params[:user_id])

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @user }
    # end
  end

  def create

    # this code shouldn't exist now that we have aasm

    # @dossier = Dossier.find(params[:dossier_id])
    # @dossier.add_status(params[:dossier_status])
    # redirect_to @dossier.user


    # raise params.inspect
    # @user = User.find_by_id(params[:user_id])
    # @user.save_with_status(params[:status])

    # redirect_to @user, notice: 'Status was successfully updated.' 
  end

end
