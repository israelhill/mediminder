class ChildDrugsController < ApplicationController
  # GET /child_drugs
  # GET /child_drugs.json
  def index
    @child_drugs = ChildDrug.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @child_drugs }
    end
  end

  # GET /child_drugs/1
  # GET /child_drugs/1.json
  def show
    @child_drug = ChildDrug.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @child_drug }
    end
  end

  # GET /child_drugs/new
  # GET /child_drugs/new.json
  def new
    @child_drug = ChildDrug.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @child_drug }
    end
  end

  # GET /child_drugs/1/edit
  def edit
    @child_drug = ChildDrug.find(params[:id])
  end

  # POST /child_drugs
  # POST /child_drugs.json
  def create
    @child_drug = ChildDrug.new(params[:child_drug])

    respond_to do |format|
      if @child_drug.save
        format.html { redirect_to @child_drug, notice: 'Child drug was successfully created.' }
        format.json { render json: @child_drug, status: :created, location: @child_drug }
      else
        format.html { render action: "new" }
        format.json { render json: @child_drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /child_drugs/1
  # PUT /child_drugs/1.json
  def update
    @child_drug = ChildDrug.find(params[:id])

    respond_to do |format|
      if @child_drug.update_attributes(params[:child_drug])
        format.html { redirect_to @child_drug, notice: 'Child drug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @child_drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /child_drugs/1
  # DELETE /child_drugs/1.json
  def destroy
    @child_drug = ChildDrug.find(params[:id])
    @child_drug.destroy

    respond_to do |format|
      format.html { redirect_to child_drugs_url }
      format.json { head :no_content }
    end
  end
end
