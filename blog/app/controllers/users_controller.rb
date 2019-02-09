class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_seo, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.page(params[:page]).per(5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize! :read, @user
  end

  # GET /users/1/edit
  def edit
    authorize! :update, @user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :update, @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user

    respond_to do |format|
      @user.destroy

      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if user_signed_in?
        if current_user == @user
          params.require(:user).permit(:name, :email)
        elsif current_user.moderator?
          params.require(:user).permit(:moderator, :creator, :banned)
        end
      end
    end

    def set_seo
      if @user.seo
        @title = @user.seo.title
        @description = @user.seo.description
        @robots = @user.seo.robots
      end
    end
end
