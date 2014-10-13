class StuReferencesController < ApplicationController
	before_filter :authenticate_user!, :get_user
  #keep user from accessing their profile if they haven't created it yet
  before_filter :profile_redir
  #keep user from accessing any method that isn't connected to their profile
  before_filter {
      |c|
    if StuReference.exists?(params[:id])
      c.deny_access(StuReference.find(params[:id].to_i).student_profile_id)
    else
      if c.get_profile_type != "student"
        c.deny_access(-1)
      end
    end}
  #redirect company if they haven't been verified
  before_filter :verified?


  # GET /stu_references
  # GET /stu_references.json
=begin
  def index
    @stu_references = StuReference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stu_references }
    end
  end
=end

  # GET /stu_references/1
  # GET /stu_references/1.json
  def show
    @stu_reference = StuReference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stu_reference }
    end
  end

  # GET /stu_references/new
  # GET /stu_references/new.json
  def new
    @stu_reference = StuReference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stu_reference }
    end
  end

  # GET /stu_references/1/edit
  def edit
    @stu_reference = StuReference.find(params[:id])
  end

  # POST /stu_references
  # POST /stu_references.json
  def create
    @stu_reference = StuReference.new(params[:stu_reference])
	@user = current_user
	@stu_reference.uid = @user.id
	@stu_reference.student_profile_id = @user.id

    respond_to do |format|
      if @stu_reference.save
        format.html { redirect_to student_profile_url(@user),
			notice: 'Reference was successfully created.' }
        format.json { render json: @stu_reference, status: :created, location: @stu_reference }
      else
        format.html { render action: "new" }
        format.json { render json: @stu_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stu_references/1
  # PUT /stu_references/1.json
  def update
    @stu_reference = StuReference.find(params[:id])

    respond_to do |format|
      if @stu_reference.update_attributes(params[:stu_reference])
        format.html { redirect_to student_profile_url(@user),
			notice: 'Reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stu_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stu_references/1
  # DELETE /stu_references/1.json
  def destroy
    @stu_reference = StuReference.find(params[:id])
    @stu_reference.destroy

    respond_to do |format|
      format.html { redirect_to student_profile_url(@user),
                                notice: 'Reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
