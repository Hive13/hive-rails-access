class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def checkin
    @member = Member.find(params[:id])
    monitor_message("[DOOR][ENTRY] #{@member.fname} #{@member.lname} has presented his/her badge to the door.")
    fsqclient = Foursquare2::Client.new(:oauth_token => @member.fsqtoken )
    fsqclient.search_venues(:ll => '39.13545607,-84.5385181903', :query => 'hive13')
    if fsqclient.add_checkin(:venueId => "4b5140ecf964a520d54827e3", :broadcast => 'public', :ll => '39.13545607,-84.5385181903', :shout => 'Checked in via RFID Badge') 
      redirect_to members_url
    end
  end

  def cardcheck
      @tmember = Member.where("accesscard = '#{params[:card]}'").first
      if @tmember.nil?
          monitor_message("[DOOR][WARNING] Card #{params[:card]} was presented at the door, but, I have no information about that card.")
          render :text => "0"
      else
        unless @tmember.fsqtoken.empty?
            fsqclient = Foursquare2::Client.new(:oauth_token => @tmember.fsqtoken )
            fsqclient.search_venues(:ll => '39.13545607,-84.5385181903', :query => 'hive13')
            fsqclient.add_checkin(:venueId => "4b5140ecf964a520d54827e3", :broadcast => 'public', :ll => '39.13545607,-84.5385181903', :shout => 'Checked in via RFID Badge')
        end
        monitor_message("[DOOR][ENTRY] #{@tmember.fname} #{@tmember.lname}'s card was presented at the door, and access was granted.")
        render :text => "1"
      end

  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end
