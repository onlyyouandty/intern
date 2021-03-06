class StudentProfilesController < ApplicationController
  #make sure the user is logged in
  before_filter :authenticate_user!, :get_user
  before_filter :get_culture, :except => [:new, :create]
  #keep user from accessing their profile if they haven't created it yet
  before_filter(:except => [:new, :create]) {|c| c.profile_redir}
  #keep user from accessing any method that isn't connected to their profile
  before_filter(:only =>[:edit, :new, :destroy, :create, :update]) {|c| c.deny_access(params[:id])}
  before_filter(:only=>[:index]) {|c| if c.get_profile_type == 'student'; c.deny_access(-1) end}
  #redirect company if they haven't been verified
  before_filter :verified?

  # GET /student_profiles
  # GET /student_profiles.json
  def index
    @student_profiles = StudentProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @student_profiles }
    end
  end

  def search
    @return = []
    @cultures = ['']
    Groups.all.each do |culture|
      @cultures.push(culture.description)
    end
    @years = ['', 'Freshman', 'Sophomore', 'Junior', 'Senior', 'N/A']

    @student_profiles_all = StudentProfile.all
    @saved = SavedStudentProfile.find_all_by_company_profile_id(@user.id)

    if params[:save_search]
      @saved_student_profile = SavedStudentProfile.new
      @saved_student_profile.company_profile_id = @user.id
      @saved_student_profile.school_text = params[:school_text]
      @saved_student_profile.year_text = params[:year_text]
      @saved_student_profile.skill_text = params[:skill_text]
      @saved_student_profile.culture = params[:culture]

      respond_to do |format|
        if @saved_student_profile.save
          format.html { redirect_to :back, notice: 'Saved student profile was successfully created.' }
          format.json { render json: @saved_student_profile, status: :created, location: @saved_student_profile }
        else
          format.html { render action: "new" }
          format.json { render json: @saved_student_profile.errors, status: :unprocessable_entity }
        end
      end
    end

    if params[:school_text]
      if params[:school_text] != "" and params[:year_text] != "" and params[:skill_text] != ""
        match_term1 = params[:school_text]
        match_term2 = params[:year_text]
        match_term3 = params[:skill_text]
        @student_profiles = StudentProfile.find_by_sql("SELECT * FROM Student_Profiles sp INNER JOIN skills s ON  sp.id = s.student_profile_id WHERE s.description LIKE '%" +
                                                           match_term3 + "%' AND sp.school LIKE '%" + match_term1 + "%' AND sp.school_year LIKE '%" + match_term2 + "%'" )
      elsif params[:school_text] != "" and params[:skill_text] != ""
        match_term1 =  params[:school_text]
        match_term2 =  params[:skill_text]
        @student_profiles = StudentProfile.find_by_sql("SELECT * FROM Student_Profiles sp INNER JOIN skills s ON  sp.id = s.student_profile_id WHERE s.description LIKE '%" +
                                                           match_term2 + "%' AND sp.School LIKE '%" + match_term1 + "%'")
      elsif params[:year_text] != "" and params[:skill_text] != ""
        match_term1 =  params[:year_text]
        match_term2 =  params[:skill_text]
        @student_profiles = StudentProfile.find_by_sql("SELECT * FROM Student_Profiles sp INNER JOIN skills s ON  sp.id = s.student_profile_id WHERE s.description LIKE '%" +
                                                           match_term2 + "%' AND sp.school_year LIKE '%" + match_term1 + "%'")
      elsif params[:year_text] != "" and params[:school_text] != ""
        match_term1 = "%" + params[:year_text] + "%"
        match_term2 = "%" + params[:school_text] + "%"
        @student_profiles = StudentProfile.where("School_year LIKE ? AND School LIKE ?", match_term1, match_term2)
      elsif params[:year_text] != ""
        match_term = "%" + params[:year_text] + "%"
        @student_profiles = StudentProfile.where("School_year LIKE ?", match_term)
      elsif params[:school_text] != ""
        match_term = "%" + params[:school_text] + "%"
        @student_profiles = StudentProfile.where("School LIKE ?", match_term)
      elsif params[:skill_text] != ""
        match_term1 = params[:skill_text]
        @student_profiles = StudentProfile.find_by_sql("SELECT * FROM Student_Profiles sp INNER JOIN skills s ON  sp.id = s.student_profile_id WHERE s.description LIKE '%" + match_term1 + "%'")
      end

      if params[:culture] != ''
        #culture is set but there are no search hits
        if @student_profiles.nil?
            @student_profiles_all.each do |profile|
              if profile.qsort == params[:culture]
                @return.append(profile)
              end
            end
        #culture is set and there are search hits
        else
          @student_profiles.each do |profile|
            if profile.qsort == params[:culture]
              @return.append(profile)
            end
          end
        end
      #culture is not set
      else
        @return = @student_profiles
      end
    else
      #when the search page is initially visited, display all interns
      #@return = @student_profiles_all
    end
    @school_text = params[:school_text]
    @year_text = params[:year_text]
    @skill_text = params[:skill_text]
    @culture = params[:culture]

  end
  
  # GET /student_profiles/1
  # GET /student_profiles/1.json
  def show

    @student_profile = StudentProfile.find(params[:id])
    @work_histories = @student_profile.stu_work_experiences(current_user.id)
    @skills = @student_profile.skills(current_user.id)
	  @references = @student_profile.stu_references(current_user.id)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student_profile }
    end
  end

  # GET /student_profiles/new
  # GET /student_profiles/new.json
  def new

    @student_profile = StudentProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student_profile }
    end
  end

  # GET /student_profiles/1/edit
  def edit

    @student_profile = StudentProfile.find(params[:id])
  end

  # POST /student_profiles
  # POST /student_profiles.json
  def create
    @student_profile = StudentProfile.new(params[:student_profile])
    @cur_user = current_user
    @student_profile.user_id = @cur_user.id
    @student_profile.id = @cur_user.id
    @student_profile.email = @cur_user.email

    respond_to do |format|
      if @student_profile.save
        format.html { redirect_to student_profile_url(@student_profile), notice: 'Student profile was successfully created.' }
        format.json { render json: @student_profile, status: :created, location: @student_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /student_profiles/1
  # PUT /student_profiles/1.json
  def update
    @student_profile = StudentProfile.find(params[:id])

    respond_to do |format|
      if @student_profile.update_attributes(params[:student_profile])
        format.html { redirect_to student_profile_url(@student_profile), notice: 'Student profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_profiles/1
  # DELETE /student_profiles/1.json
  def destroy
    @student_profile = StudentProfile.find(params[:id])
    @student_profile.destroy

    respond_to do |format|
      format.html { redirect_to student_profiles_url }
      format.json { head :no_content }
    end
  end
end
