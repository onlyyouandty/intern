class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.user_type == "admin"
      flash[:alert] = "Unauthorized Access!"
      if current_user.user_type == "student"
        redirect_to student_profile_url(current_user.id)
      else
        redirect_to company_profile_url(current_user.id)
      end
    end
   end

  # read the output of the qsort function and save the user's grouping into the database
  def get_culture
    id = current_user.id.to_s

    #read in file and save ids:grouping into a hash
    lines = File.read('public/qsort_in.txt').split("\n")

    h = Hash.new
    lines.each do |line|
      s = line.split(' ', 2)
      h[s[0]] = s[1]
    end

    #if a grouping exists in the file for the id, save it in the StudentProfile table
    if !h[id].nil?
      if get_profile_type == "student"
        profile = StudentProfile.find(id)
      elsif get_profile_type == "company"
        profile = CompanyProfile.find(id)
      end

      profile.qsort = Groups.find(h[id].to_i).description
      profile.update_attributes(params[:profile])
    end
  end




  #page lockdown method
  def deny_access(param_id)

    #if the user doesn't have a profile yet, exit method
    if !StudentProfile.exists?(current_user.id) && !CompanyProfile.exists?(current_user.id)
      return
    end
    #redirects user if they shouldn't access a page
    if get_profile_type == "student"
      cur_profile = StudentProfile.find(current_user.id)
      if param_id.to_i != cur_profile.id
        redirect_to student_profile_url(cur_profile), notice: 'You are not authorized to access that page!'
      end
    elsif get_profile_type == "company"
      cur_profile = CompanyProfile.find(current_user.id)
      if param_id.to_i != cur_profile.id
        redirect_to company_profile_url(cur_profile), notice: 'You are not authorized to access that page!'
      end
    end
  end

  #Returns the type of profile for the current user
  def get_profile_type
    return current_user.user_type
  end

  #checks if profile with the given id exists, if not, it redirects them to new
  def profile_redir
    if get_profile_type == "student"
      if !StudentProfile.exists?(current_user.id)
        redirect_to new_student_profile_url, notice: 'You are not authorized to access that page yet!'
      end
    elsif get_profile_type == "company"
      if !CompanyProfile.exists?(current_user.id)
        redirect_to new_company_profile_url, notice: 'You are not authorized to access that page yet!'
      end
    end
  end

  #gets the current user's profile
  def get_user
    if get_profile_type == "student"
      @user = StudentProfile.find_by_user_id(current_user.id.to_s)
    elsif get_profile_type == "company"
      @user = CompanyProfile.find_by_user_id(current_user.id.to_s)
    else #for admin
      @user = current_user
    end
  end

  #Redirects the user after successful sign in
  def after_sign_in_path_for(user)
    user_type = current_user.user_type
    user_id = current_user.id.to_s

    if user_type == "student"
      student_profile_url(user_id)

    elsif user_type == "company"
      company_profile_url(user_id)

    elsif user_type == "admin"
      admin_root_url
    else
      #do nothing here. There isn't another kind of user but I wanted to be specific for the admin case in
      #case there is some hole I'm not thinking of like a user being able to get access without having a
      #type
    end
  end

  def verified?
    if CompanyProfile.exists?(current_user.id)
      @company_profile = CompanyProfile.find(get_user.id)

      if(@company_profile.verified != true)
        redirect_to company_profile_url(@company_profile), notice: "Your profile needs to be approved before you can do that!"
      end
    end
  end

end