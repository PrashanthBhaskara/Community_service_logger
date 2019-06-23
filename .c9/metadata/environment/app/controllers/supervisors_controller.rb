{"changed":true,"filter":false,"title":"supervisors_controller.rb","tooltip":"/app/controllers/supervisors_controller.rb","value":"class SupervisorsController < ApplicationController\n  before_action :validate_url_hack, only: [:edit, :update]\n  before_action :logged_in_supervisor, only: [:edit, :update]\n  before_action :correct_supervisor,   only: [:edit, :update]\n  \n  \n  def new\n    @supervisor = Supervisor.new\n  end\n  \n  def create\n    @supervisor = Supervisor.create(supervisor_params)\n    if @supervisor.save\n      @supervisor.send_activation_email\n      flash[:info] = \"Please check your email to activate your account\"\n      redirect_to root_url\n    else\n      render 'new'\n    end\n  end\n  \n  \n  def show\n    @supervisor = Supervisor.find(params[:id])\n    @approves = Hour.where(email: @supervisor.email, approved: nil)\n  end\n  \n  def approve\n  end\n  \n  def yes\n    @supervisor = current_supervisor\n    @approves = Hour.where(email: @supervisor.email, approved: nil)\n    @hour = Hour.find(params[:id])\n    @hour.approve_hour\n    redirect_to current_supervisor\n  end\n  \n  def no\n    @supervisor = current_supervisor\n    @approves = Hour.where(email: @supervisor.email, approved: nil)\n    @hour = Hour.find(params[:id])\n    @hour.deny_hour\n    redirect_to current_supervisor\n  end\n  \n  private\n  \n  def supervisor_params\n    params.require(:supervisor).permit(:id, :first_name, :last_name, :email, :address, :telephone, :role, :organization, :password, :password_confirmation, :access_code, { hour: [:content, :approved]})\n  end\n  \n  def logged_in_supervisor\n    unless logged_in_supervisor\n       flash[:danger] = \"Please log in\"\n       redirect_to root_url\n    end\n  end\n   \n   def correct_supervisor\n     @supervisor = Supervisor.find(params[:id])\n     redirect_to(root_url) unless @supervisor == current_supervisor?(@supervisor)\n   end\n   \n  def validate_url_hack\n    unless params[:id].to_i == current_supervisor.id\n      flash[:danger] = \"Please log in\"\n      redirect_to root_url\n    end\n  end\n   \n  \n  \nend\n\n","undoManager":{"mark":1,"position":2,"stack":[[{"start":{"row":73,"column":3},"end":{"row":74,"column":0},"action":"insert","lines":["",""],"id":7},{"start":{"row":74,"column":0},"end":{"row":75,"column":0},"action":"insert","lines":["",""]}],[{"start":{"row":75,"column":0},"end":{"row":75,"column":61},"action":"insert","lines":["<%= render partial: 'supervisor', collection: @supervisors %>"],"id":8}],[{"start":{"row":75,"column":0},"end":{"row":75,"column":61},"action":"remove","lines":["<%= render partial: 'supervisor', collection: @supervisors %>"],"id":9}]]},"ace":{"folds":[],"scrolltop":761.7578125,"scrollleft":0,"selection":{"start":{"row":75,"column":0},"end":{"row":75,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":35,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1561323539215}