class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  def index
    @members = Member.all
    
    @vendCredits = Member.sum('vend_credits')
    @vendTotal = Member.sum('vend_total')
    @doorOpens = Member.sum('door_count')
    @memberCount = Member.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])
    raise CanCan::AccessDenied if cannot? :show, @member

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
    raise CanCan::AccessDenied if cannot? :edit, @member
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

  def enrollcard

  end

  def cardcheck
      @tmember = Member.where("accesscard = '#{params[:card]}'").first
      if @tmember.nil?
        render :text => "0", :status => 201
      else
        if @tmember.is_lockedout = false
          render :text => "LockedOut", :status => 201
        else
          CheckinWorker.perform_async(@tmember.id)
          @tmember.last_access = Time.now

          if @tmember.door_count.nil?
            @tmember.door_count = 1
          else
            @tmember.door_count = @tmember.door_count + 1
          end

          if @tmember.is_admin != true
            mixpanel.track 'DoorOpen', { :card => "#{params[:card]}" }
          end
          render :text => "1", :staus => 200
        end
      end
  end

  def vendcheck
      @tmember = Member.where("accesscard = '#{params[:card]}'").first
      if @tmember.nil?
          monitor_message("[VEND][WARNING] Card #{params[:card]} was presented at the vending machine, but I have no information about that card.")
          render :text => "0", :status => 201
      else
          if @tmember.vend_enabled == true
              # Oh, I should tweet!
              @tmember.vend_total = @tmember.vend_total + 1
              @tmember.save
              if @tmember.is_admin != true
                mixpanel.track 'SodaVend', { :card => "#{params[:card]}" }
              end
              render :text => "Credit: #{@tmember.vend_credits}, Total: #{@tmember.vend_total}, Vend:#{@tmember.vend_enabled}", :status => 200
          else
              if @tmember.vend_credits > 0
                  @tmember.vend_total = @tmember.vend_total + 1
                  @tmember.vend_credits = @tmember.vend_credits - 1
                  @tmember.save
                  mixpanel.track 'SodaVend', { :card => "#{params[:card]}" }
                  render :text => "Credit: #{@tmember.vend_credits}, Total: #{@tmember.vend_total}, Vend:#{@tmember.vend_enabled}", :status => 200 
              else
                  monitor_message("[VEND][WARNING] #{@tmember.fname} #{@tmember.lname}'s card was presented at the vending machine, but, he is not vend_enabled.")
                  render :text => "Credit: #{@tmember.vend_credits}, Total: #{@tmember.vend_total}, Vend:#{@tmember.vend_enabled}", :status => 201 
              end
          end
      end
  end

  def testcheck
      @tmember = Member.where("accesscard = '#{params[:card]}'").first
      if @tmember.nil?
          render :text => "0", :status => 201
      else
        render :text => "1", :status => 200
      end
  end


  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    if @member.vend_total.nil?
      @member.vend_total = 0
    end

    if @member.vend_credits.nil?
      @member.vend_credits = 1
    end
    
    if @member.door_count.nil?
        @member.door_count = 0
    end
    

    raise CanCan::AccessDenied if cannot? :edit, @member

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
    raise CanCan::AccessDenied if cannot? :delete, @member
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
  
  def lockout
    @member = Member.find(params[:id])
    @member.toggle(:is_lockedout)
    @member.save    
    redirect_to members_url
  end

  def setprivacy
    @member = Member.find(params[:id])
    @member.toggle(:is_private)
    @member.save
    redirect_to root_url
  end
  
  
  
end
