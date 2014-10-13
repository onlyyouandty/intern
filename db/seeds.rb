# These are entries to automatically add to the database with rake db:seed
# For the attributes and groupings, the associated ID# depends on the order of their creation, starting at 1

# Define the admin accounts
User.create(:email => 'admin@interns.com',
            :user_type => 'admin',
            :password => 'password',
            :password_confirmation => 'password')

User.create(:email => 'TMuscare@cdm.depaul.edu',
            :user_type => 'admin',
            :password => 'password',
            :password_confirmation => 'password')


# List the attitudinal attributes
attributes = ["Creative",
     "Problem Solver",
     "Good Listener",
     "Oral/Verbal Communication",
     "Writing Skill",
     "Flexibility (work scheduling)",
     "People Skills",
     "Punctual",
     "Accurate",
     "Efficient",
     "Multi-Tasker",
     "Analytical",
     "Ability to Plan",
     "Skilled Researcher",
     "Reflective",
     "Leadership",
     "Teamwork",
     "Stamina",
     "Fast paced worker"]


# List the culture groupings.
groupings = ["Grouping One",
             "Grouping Two",
             "Grouping Three",
             "Grouping Four",
             "Grouping Five",
             "Grouping Six",
             "Grouping Seven"]



# Add the groupings and attributes to database
attributes.each do |att|
  n = Qsort.create(name: att)
  n.position = n.id
  n.save
end

groupings.each do |grp|
  n = Groups.create(description: grp)
end

