class ChildTodaysController < ApplicationController
  # GET /child_todays
  # GET /child_todays.json
  def index
    @child_todays = ChildToday.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_todays }
    end
  end

  # GET /child_todays/1
  # GET /child_todays/1.json
  def show
    @child_today = ChildToday.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_today }
    end
  end

  # GET /child_todays/new
  # GET /child_todays/new.json
  def new
    @child_today = ChildToday.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_today }
    end
  end

  # GET /child_todays/1/edit
  def edit
    @child_today = ChildToday.find(params[:id])
  end

  # POST /child_todays
  # POST /child_todays.json
  def create
    @child_today = ChildToday.new(params[:child_today])

    respond_to do |format|
      if @child_today.save
        format.html { redirect_to @child_today, notice: 'Child today was successfully created.' }
        format.json { render json: @child_today, status: :created, location: @child_today }
      else
        format.html { render action: "new" }
        format.json { render json: @child_today.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /child_todays/1
  # PUT /child_todays/1.json
  def update
    @child_today = ChildToday.find(params[:id])

    respond_to do |format|
      if @child_today.update_attributes(params[:child_today])
        format.html { redirect_to @child_today, notice: 'Child today was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_today.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /child_todays/1
  # DELETE /child_todays/1.json
  def destroy
    @child_today = ChildToday.find(params[:id])
    @child_today.destroy

    respond_to do |format|
      format.html { redirect_to child_todays_url }
      format.json { head :no_content }
    end
  end
end
