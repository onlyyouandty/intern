class SavedJobPostingsController < ApplicationController
  before_filter :authenticate_user!
  #keep user from accessing their profile if they haven't created it yet
  before_filter :profile_redir
  #redirect company if they haven't been verified
  before_filter :verified?
  #keep user from accessing any method that isn't connected to their profile
  before_filter {
      |c|
    if SavedJobPosting.exists?(params[:id])
      c.deny_access(SavedJobPosting.find(params[:id]).student_profile_id)
    else
      if c.get_profile_type != "student"
        c.deny_access(-1)
      end
    end}

  # GET /saved_job_postings/1/edit
  def edit
    @saved_job_posting = SavedJobPosting.find(params[:id])
    @cultures = ['']
    Groups.all.each do |culture|
      @cultures.push(culture.description)
    end
    #@pay = ['', 'Paid', 'Unpaid']
  end

  # PUT /saved_job_postings/1
  # PUT /saved_job_postings/1.json
  def update
    @saved_job_posting = SavedJobPosting.find(params[:id])

    respond_to do |format|
      if @saved_job_posting.update_attributes(params[:saved_job_posting])
        format.html { redirect_to search_job_postings_url, notice: 'Saved search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saved_job_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_job_postings/1
  # DELETE /saved_job_postings/1.json
  def destroy
    @saved_job_posting = SavedJobPosting.find(params[:id])
    @saved_job_posting.destroy

    respond_to do |format|
      format.html { redirect_to search_job_postings_url, :notice => 'Saved search was successfully destroyed' }
      format.json { head :no_content }
    end
  end
end
