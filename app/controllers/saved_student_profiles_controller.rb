class SavedStudentProfilesController < ApplicationController
  before_filter :authenticate_user!
  #keep user from accessing their profile if they haven't created it yet
  before_filter :profile_redir
  #redirect company if they haven't been verified
  before_filter :verified?
  #keep user from accessing any method that isn't connected to their profile
  before_filter {
      |c|
    if SavedStudentProfile.exists?(params[:id])
      c.deny_access(SavedStudentProfile.find(params[:id]).company_profile_id)
    else
      if c.get_profile_type != "company"
        c.deny_access(-1)
      end
    end}

  # GET /saved_student_profiles/1/edit
  def edit
    @saved_student_profile = SavedStudentProfile.find(params[:id])
    @cultures = ['']
    Groups.all.each do |culture|
      @cultures.push(culture.description)
    end
  end

  # PUT /saved_student_profiles/1
  # PUT /saved_student_profiles/1.json
  def update
    @saved_student_profile = SavedStudentProfile.find(params[:id])

    respond_to do |format|
      if @saved_student_profile.update_attributes(params[:saved_student_profile])
        format.html { redirect_to search_student_profiles_url, notice: 'Saved search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saved_student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_student_profiles/1
  # DELETE /saved_student_profiles/1.json
  def destroy
    @saved_student_profile = SavedStudentProfile.find(params[:id])
    @saved_student_profile.destroy

    respond_to do |format|
      format.html { redirect_to search_student_profiles_url, :notice => 'Saved search was successfully destroyed'}
      format.json { head :no_content }
    end
  end
end
