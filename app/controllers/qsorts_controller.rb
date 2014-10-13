class QsortsController < ApplicationController
  # GET /qsorts
  # GET /qsorts.json\
  before_filter :authenticate_user!, :get_user
  #keep user from accessing pages if they haven't created their profile yet
  before_filter :profile_redir


  def index
    #@qsorts = Qsort.all
    #@qsorts = Qsort.order('qsorts.position ASC')
    @id = current_user.id.to_s

    @lines = File.read('public/qsort.txt').split("\n")

    @h = Hash.new
    @lines.each do |line|
      s = line.split(' ', 2)
      @h[s[0]] = s[1]
    end

    if !@h[@id].nil?
      s = @h[@id].split()
      @qsorts = []
      s.each do |id|
        @qsorts.append(Qsort.find(id))
      end
    else
      @qsorts = Qsort.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qsorts }
    end
  end

  def sort
    @id = current_user.id.to_s

    @qsorts = Qsort.all
    @qsorts.each do |qsort|
      qsort.position = params['qsort'].index(qsort.id.to_s)+1
      qsort.save
    end

    @lines = File.read('public/qsort.txt').split("\n")

    @h = Hash.new
    @lines.each do |line|
      s = line.split(' ', 2)
      @h[s[0]] = s[1]
    end

#h is filled with all ids as a key and related positions as a string

    @h[@id] = ''

    @items = Qsort.order('qsorts.position ASC')
    @items.each do |item|
      #@temp = item.id.to_s.concat(' ')
      @h[@id].concat(item.id.to_s.concat(' '))
    end


#store hash in s
    s = ''
    @h.each do |id,line|
      s.concat("#{id} #{line}\n")
    end

#write s to file
    File.write('public/qsort.txt', s)

=begin
    @items = Qsort.order('qsorts.position ASC')
    @items.each do |item|
      @lst.append(item.id)
    end
    f.puts(@lst.join(' '))
    f.close
=end

    render :nothing => true
  end



  # GET /qsorts/1
  # GET /qsorts/1.json
  def show
    @qsort = Qsort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qsort }
    end
  end

  # GET /qsorts/new
  # GET /qsorts/new.json
  def new
    @qsort = Qsort.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qsort }
    end
  end

  # GET /qsorts/1/edit
  def edit
    @qsort = Qsort.find(params[:id])
  end

  # POST /qsorts
  # POST /qsorts.json
  def create
    @qsort = Qsort.new(params[:qsort])

    respond_to do |format|
      if @qsort.save
        format.html { redirect_to @qsort, notice: 'Qsort was successfully created.' }
        format.json { render json: @qsort, status: :created, location: @qsort }
      else
        format.html { render action: "new" }
        format.json { render json: @qsort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qsorts/1
  # PUT /qsorts/1.json
  def update
    @qsort = Qsort.find(params[:id])

    respond_to do |format|
      if @qsort.update_attributes(params[:qsort])
        format.html { redirect_to @qsort, notice: 'Qsort was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qsort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qsorts/1
  # DELETE /qsorts/1.json
  def destroy
    @qsort = Qsort.find(params[:id])
    @qsort.destroy

    respond_to do |format|
      format.html { redirect_to qsorts_url }
      format.json { head :no_content }
    end
  end
end
