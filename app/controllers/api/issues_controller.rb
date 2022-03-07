class Api::IssuesController < ApplicationController

  before_action :authenticate_user, only: [:create, :update]
  before_action :authenticate_admin, only: :destroy

  def index
    @issues = Issue.where(app_id: params[:id])
    render 'index'
  end

  def create
    @issue = Issue.new(
      type: params[:type],
      severity: params[:severity],
      summary: params[:summary],
      description: params[:description],
      time: params[:time],
      char_name: params[:char_name],
      impact: params[:impact],
      category: params[:category],
      internal: params[:internal],
      status: params[:status] || "pending",
      app_id: params[:location_id],
      location_id: params[:location_id]      
      )
    if @issue.save
      @user_issue_submitter = UserIssue.new(
        user_id: current_user.id,
        issue_id: @issue.id,
        role: "Submitter"
      )
      @user_issue_owner = UserIssue.new(
        issue_id: @issue.id,
        user_id: 1,
        role: "Owner"
      )
      if @user_issue_submitter.save && @user_issue_owner.save
        render 'show'
      else
        @issue.destroy
        render json:{errors_submitter: @user_issue_submitter.errors.full_messages, errors_owner: @user_issue_owner.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json:{errors: @issue.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @issue = Issue.find(params[:id])
    if @issue
      render 'show'
    else
      render json:{message: "Issue not found."}
    end
  end

  def update
    @issue = Issue.find(params[:id])

    if authenticate_self || authenticate_admin

      @issue.type = params[:type] || @issue.type
      @issue.severity = params[:severity] || @issue.severity
      @issue.summary = params[:summary] || @issue.summary
      @issue.description = params[:description] || @issue.description
      @issue.time = params[:time] || @issue.time
      @issue.char_name = params[:char_name] || @issue.char_name
      @issue.impact = params[:impact] || @issue.impact
      @issue.category = params[:category] || @issue.category
      @issue.internal = params[:internal] || @issue.internal
      @issue.status = params[:status] || @issue.status
      @issue.location_id = params[:location_id] || @issue.location_id

      @owner_update = true

      if params[:owner_id]
        @user_issue_owner = UserIssue.find_by(issue_id: @issue.id, role: "Owner")
        @user_issue_owner.user_id = params[:owner_id]
          
        if @user_issue_owner.save   
        else
          @owner_update = false
        end
      end
      
      
      if @issue.save
        if @owner_update
          render 'show'
        else
          render json:{errors: @user_issue_owner.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json:{errors: @issues.errors.full_messages}, status: :unprocessable_entity
      end
      
      # render json:{message: "You are not authorized to edit this issue."}

    end


  end
    
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    render json:{message: "Issue has been deleted."}
  end


end
