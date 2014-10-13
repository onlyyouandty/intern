class StuWorkExperiencesController < ApplicationController

  before_filter :authenticate_user!, :get_user
  #keep user from accessing their profile if they haven't created it yet
  before_filter :profile_redir
  #keep user from accessing any method that isn't connected to their profile
  before_filter(:except =>:index) {
      |c|
    if StuWorkExperience.exists?(params[:id])
      c.deny_access(StuWorkExperience.find(params[:id].to_i).student_profile_id)
    else
      if c.get_profile_type != "student"
        c.deny_access(-1)
      end
    end}
  #redirect company if they haven't been verified
  before_filter :verified?

  # GET /stu_work_experiences
  # GET /stu_work_experiences.json
=begin
  def index
    @stu_work_experiences = StuWorkExperience.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stu_work_experiences }
    end
  end
=end

  # GET /stu_work_experiences/1
  # GET /stu_work_experiences/1.json
  def show
    @stu_work_experience = StuWorkExperience.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stu_work_experience }
    end
  end

  # GET /stu_work_experiences/new
  # GET /stu_work_experiences/new.json
  def new
    @stu_work_experience = StuWorkExperience.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stu_work_experience }
    end
  end

  # GET /stu_work_experiences/1/edit
  def edit
	@stu_work_experience = StuWorkExperience.find(params[:id])
  end

  # POST /stu_work_experiences
  # POST /stu_work_experiences.json
  def create
    @stu_work_experience = StuWorkExperience.new(params[:stu_work_experience])
    #@user = current_user
    @stu_work_experience.student_profile_id = @user.id


    respond_to do |format|
      if @stu_work_experience.save
		    format.html { redirect_to student_profile_path(@user), notice:
							'Work Experience was successfully created.' }
							
        #format.html { redirect_to @stu_work_experience, notice: 'Stu work experience was successfully created.' }
        #format.json { render json: stud@stu_work_experience, status: :created, location: @stu_work_experience }
      else
        format.html { render action: "new" }
        format.json { render json: @stu_work_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stu_work_experiences/1
  # PUT /stu_work_experiences/1.json
  def update
  @stu_work_experience = StuWorkExperience.find(params[:id])
   #@stu_work_experience = StuWorkExperience.find(params[:id])

    respond_to do |format|
      if @stu_work_experience.update_attributes(params[:stu_work_experience])
        format.html { redirect_to student_profile_path(@user), notice:
            'Work Experience was successfully updated.' }
		#format.html { redirect_to @stu_work_experience, notice: 'Stu work experience was successfully updated.' }
        
		format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stu_work_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stu_work_experiences/1
  # DELETE /stu_work_experiences/1.json
  def destroy
    @stu_work_experience = StuWorkExperience.find(params[:id])
	#@stu_work_experience = StuWorkExperience.find(params[:id])
    @stu_work_experience.destroy

    respond_to do |format|
      format.html {redirect_to student_profile_url(@user), notice:
          'Work Experience was successfully deleted.'  }
	  #format.html { redirect_to stu_work_experiences_url }
      format.json { head :no_content }
    end
  end

end
