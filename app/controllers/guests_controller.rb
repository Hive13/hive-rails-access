require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/prawn_outputter'


class GuestsController < ApplicationController
  # GET /guests
  # GET /guests.json
  def index
    @guests = Guest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])
    guestid = @guest.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
      format.pdf do
        pdf = Prawn::Document.new(:template => Rails.root.to_s + "/public/static/HIVE13.liability.waver_.form_.2011.10.01.pdf")
        pdf.text_box "#{@guest.fname} #{@guest.lname}", :at => [140,513]
        pdf.text_box "#{@guest.fname} #{@guest.lname} (#{@guest.id})", :at => [200,12]
                 
        pdf.bounding_box [200,13], :width => 100 do
          barcode = Barby::Code128B.new("#{@guest.strHash}")
          barcode.annotate_pdf(pdf, :height => 30)
        end
        
        send_data pdf.render, filename: "waiver_#{@guest.id}",
                              type: "application/pdf",
                              disposition: "inline" 
      end
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])

    # Time in should be now
    @guest.date_in = Time.now    
    @guest.strHash = Array.new(16){rand(36).to_s(36)}.join


    respond_to do |format|
      if @guest.save
        BadgeprinterWorker.perform_async(@guest.id)
        WaiverprinterWorker.perform_async(@guest.id)
        WaiverMailer.welcome_email(@guest).deliver
        mixpanel.track 'NewGuest', { :time => @guest.date_in, :email => @guest.email }

        format.html { redirect_to '/guests/new', notice: 'Thanks for signing in!  Your badge and liability waiver should print shortly!' }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url }
      format.json { head :no_content }
    end
  end
end
